//
//  ViewController.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var offlineIcon: UIImageView!
    
    var serviceHelper = ServiceHelper()
    private var eventViewModel : EventViewModel!
    private var dataSource : EventViewModelDataSource!
    private let refreshControl = UIRefreshControl()
    var loadingObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setOfflineMesage()
        self.UpdateEventUserInterface()
    }
    
    
    func UpdateEventUserInterface(){
        self.startAnimatingIndicator()
        self.eventViewModel =  EventViewModel()
        self.eventViewModel.bindEEventViewModelToController = {
            self.refreshControl.endRefreshing()
            self.setOfflineMesage()
            self.updateview()
            self.stopAnimatingIndicator()
        }
    }
    
    func updateview(){
        
        self.dataSource = EventViewModelDataSource(items: self.eventViewModel.eventViewModel, dateArray: self.eventViewModel.dateArray)
        DispatchQueue.main.async {
            self.prepareSubViews()
            self.eventTableView.reloadData()
        }
        
        self.dataSource.onPushToDetailsPage = {[weak dataSource] (_ viewModel : EventModel.Create.ViewModel) in
            let storyBoard = UIStoryboard(name:"Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: EventDetailsViewController.className) as! EventDetailsViewController
            vc.viewModel = viewModel
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }
    
    private func prepareSubViews() {
        
        //Prepare tableView
        self.eventTableView.registerCells(cells: [EventDetailListCell.className])
        self.eventTableView.backgroundColor = UIColor.white
        self.eventTableView?.allowsSelection = false
        self.eventTableView?.estimatedRowHeight = 60
        self.eventTableView?.rowHeight = UITableView.automaticDimension
        self.eventTableView?.delegate = dataSource
        self.eventTableView?.dataSource = dataSource
        self.eventTableView.showsVerticalScrollIndicator = false
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            self.eventTableView.refreshControl = refreshControl
        } else {
            self.eventTableView.addSubview(refreshControl)
        }
    }
    
    func startAnimatingIndicator(){
        self.activityIndicator.startAnimating()
    }
    
    func stopAnimatingIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        UpdateEventUserInterface()
    }
    
    fileprivate func setOfflineMesage() {
    offlineIcon.isHidden = ConnectionManager.shared.hasConnectivity()
    }
    
}
