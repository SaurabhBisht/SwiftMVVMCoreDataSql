//
//  EventDetailsViewController.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 28/08/2021.
//

import UIKit


class EventDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var eventDetailsTableView: UITableView!
    var viewModel = EventModel.Create.ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSubViews()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    private func prepareSubViews() {
        //Prepare tableView
        self.eventDetailsTableView.registerCells(cells: [SpecificEventDetailListCell.className])
        self.eventDetailsTableView.backgroundColor = UIColor.white
        self.eventDetailsTableView?.allowsSelection = false
        self.eventDetailsTableView?.estimatedRowHeight = 45
        self.eventDetailsTableView?.rowHeight = UITableView.automaticDimension
        self.eventDetailsTableView?.delegate = self
        self.eventDetailsTableView?.dataSource = self
        self.eventDetailsTableView.tableFooterView = UIView()
        self.eventDetailsTableView.showsVerticalScrollIndicator = false
    }
    
    
    // MARK: -
    // MARK: - TableView Delegates and Datasource
    // MARK: -
    // MARK: -
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return  headerView(text: "DETAILS", top: 18)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SpecificEventDetailListCell.className, for: indexPath) as! SpecificEventDetailListCell
        if let cellUpdate = cell as? CellUpdatable {
            //viewModel.index = indexPath.row
            cellUpdate.update(viewModel, index: indexPath.row)
        }
        return cell
    }
    
    
    fileprivate func headerView(text: String, top: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 103/255.0, green: 109/255.0, blue: 118/255.0, alpha: 1)
        label.text = text
        //label.addCharacterSpacing()
        headerView.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
        headerView.addSubview(label)
        let maxSize = CGSize(width: headerView.frame.size.width, height: 30)
        let size = label.sizeThatFits(maxSize)
        label.frame.size = size
        headerView.addConstraints([NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: headerView, attribute: .leading, multiplier: 1, constant: 16), NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: CGFloat(top))])
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return headerView
    }
}

class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T{
        didSet{
            
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?){
        self.listener = listener
        listener?(value)
    }
}

