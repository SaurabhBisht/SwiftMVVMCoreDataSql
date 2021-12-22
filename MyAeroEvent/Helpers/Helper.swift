//
//  Helper.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 28/08/2021.
//

import Foundation

protocol CellUpdatable {
   func update(_ item: EventModel.Create.ViewModel, index: Int?)
   func updatePointersToData(section : Int, row : Int, pageUpdate: PageUpdateable)
   var  attachedSection: Int {get set}
   var  attachedRowIndex: Int {get set}

}

class PageUpdateable: NSObject{
   var  onCellSelect : ((_ section : Int,_ row : Int) -> ())?
   override init() {}
}

