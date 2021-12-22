//
//  TableViewExtension.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import UIKit

extension UITableView {
    
    /// Register the cell with cell Xib name
    func registerCells(cells: Array<String>) {
        cells.forEach { (cellname) in
            self.register(UINib(nibName: cellname, bundle: nil), forCellReuseIdentifier: cellname)
        }
    }
}

