//
//  EventViewModelDataSource.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//


import Foundation
import UIKit

class EventViewModelDataSource : PageUpdateable, UITableViewDelegate, UITableViewDataSource {
    
    private var eventViewModel = [EventModel.Create.ViewModel]()
    var dateArray = [String]()
    var pageUpdate : PageUpdateable?
    var  onPushToDetailsPage : ((_ viewModel : EventModel.Create.ViewModel) -> ())?
    
    init(items :  [EventModel.Create.ViewModel], dateArray: [String]) {
        super.init()
        eventViewModel = items
        self.dateArray = dateArray
        pageUpdate = PageUpdateable()
        showDetailsPage()
    }

    // MARK: -
    // MARK: - TableView Delegates and Datasource
    // MARK: -
    // MARK: -
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents(section).count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return  headerView(text: dateArray[section], top: 18)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: EventDetailListCell.className, for: indexPath) as! EventDetailListCell
       
        if let cellUpdate = cell as? CellUpdatable {
            cellUpdate.updatePointersToData(section : indexPath.section, row : indexPath.row, pageUpdate: pageUpdate ?? PageUpdateable())
            cellUpdate.update(filteredEvents(indexPath.section)[indexPath.row], index: 0)
            
        }
        return cell
    }

    /// Header View
    /// For Section
    fileprivate func headerView(text: String, top: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 103/255.0, green: 109/255.0, blue: 118/255.0, alpha: 1)
        label.text =  (text.uppercased() == "NA") ? "NA" : "\(text.split(separator: "/")[0]) \(getMonth(text, label)) \(text.split(separator: "/")[2])"
        //label.addCharacterSpacing()
        headerView.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
        headerView.addSubview(label)
        let maxSize = CGSize(width: headerView.frame.size.width, height: 18)
        let size = label.sizeThatFits(maxSize)
        label.frame.size = size
        headerView.addConstraints([NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: headerView, attribute: .leading, multiplier: 1, constant: 16), NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: CGFloat(top))])
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return headerView
    }
    
    
    fileprivate func filteredEvents(_ section: Int) -> [EventModel.Create.ViewModel] {
        return self.eventViewModel.filter { (evt) -> Bool in
            return evt.date == dateArray[section]
        }
    }
    
    /// Extracts month
    /// Returns First Three Chars
    fileprivate func getMonth(_ text: String, _ label: UILabel)-> String {
        if (text.uppercased() == "NA"){
            return text
        }
        
        let txt = text.split(separator: "/")[1]
        let fmt = DateFormatter()
        fmt.dateFormat = "MM"
        let month = fmt.monthSymbols[Int(txt) ?? 2 - 1]
        return String(month.prefix(3))
    }
    
    
    /// On Row Selection
    /// Closure
    /// Navigation
    fileprivate func showDetailsPage() {
        pageUpdate?.onCellSelect = { [weak pageUpdate] (section, row) in
        self.onPushToDetailsPage?(self.filteredEvents(section)[row])
        }
    }
}

