//
//  EventDetailListCell.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import UIKit

class EventDetailListCell: UITableViewCell, CellUpdatable {

    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var centerTopLbl: UILabel!
    @IBOutlet weak var centerBottomLbl: UILabel!
    @IBOutlet weak var rightTopLbl: UILabel!
    @IBOutlet weak var rightBottomLbl: UILabel!
    
    var attachedSection: Int = 0
    var attachedRowIndex: Int = 0
    var pageUpdate = PageUpdateable()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updatePointersToData(section : Int, row : Int, pageUpdate: PageUpdateable) {
        self.attachedSection = section
        self.attachedRowIndex = row
        self.pageUpdate = pageUpdate
    }
    
    
    func update(_ item: EventModel.Create.ViewModel, index: Int?) {
        centerTopLbl.isHidden    = false
        centerBottomLbl.isHidden = false
        rightTopLbl.isHidden     = false
        rightBottomLbl.isHidden  = false
        
        switch item.dutyCode?.uppercased() {
        case Constants.DutyCode.FLIGHT.uppercased():
            
            centerTopLbl.text        = "\(item.departure ?? "") - \(item.destination ?? "")"
            centerBottomLbl.isHidden = true
            rightTopLbl.isHidden     = true
            rightBottomLbl.text      = "\(item.timeDepart ?? "") - \(item.timeArrive ?? "")"
            icon.image = UIImage(named: "Airport")
            
        case Constants.DutyCode.OFF:
            
            centerTopLbl.text = item.dutyID?.uppercased()
            centerBottomLbl.isHidden = true
            rightTopLbl.isHidden = true
            rightBottomLbl.isHidden = true
            icon.image = UIImage(named: "Off")
            
        case Constants.DutyCode.POSITIONING.uppercased():
            
            centerTopLbl.text = item.dutyID
            centerBottomLbl.isHidden = true
            rightTopLbl.isHidden = true
            rightBottomLbl.text  = "\(item.timeDepart ?? "") - \(item.timeArrive ?? "")"
            icon.image = UIImage(named: "Positioning")
            
        case Constants.DutyCode.STANDBY.uppercased():
            
            centerTopLbl.text    = item.dutyID
            centerBottomLbl.text = "\(item.dutyID ?? "") (\(item.destination ?? ""))"
            rightTopLbl.text     = "Match Crew"
            rightBottomLbl.text  = "\(item.timeDepart ?? "") - \(item.timeArrive ?? "")"
            icon.image = UIImage(named: "Note")
            
        case Constants.DutyCode.LAYOVER.uppercased():
            
            centerTopLbl.text    = item.dutyID
            centerBottomLbl.text = item.destination
            rightTopLbl.isHidden = true
            rightBottomLbl.text  = "93.05 Hours"
            icon.image = UIImage(named: "Baggage")
            
        default:
            print("Invalid!")
        }
       
        centerBottomLbl.text = item.dutyID
    }
    
    
    @IBAction func rowSelectAction(_ sender: Any) {
        pageUpdate.onCellSelect?(attachedSection, attachedRowIndex)
    }
    
}
