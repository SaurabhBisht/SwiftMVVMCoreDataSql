//
//  SpecificEventDetailListCell.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 28/08/2021.
//


import UIKit

class SpecificEventDetailListCell: UITableViewCell, CellUpdatable {
   
    var attachedSection: Int = 0
    var attachedRowIndex: Int = 0
  
   
    @IBOutlet weak var contentVw: UIView!
    @IBOutlet weak var keyLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(_ item: EventModel.Create.ViewModel, index: Int?) {
        switch index {
        case 0:
            self.keyLbl.text   = Constants.EventDetails.Flightnr.rawValue
            self.valueLbl.text =  item.flightnr?.isEmpty ?? true ? "NA" : item.flightnr
        case 1:
            self.keyLbl.text   = Constants.EventDetails.Date.rawValue
            self.valueLbl.text = item.date?.isEmpty ?? true ? "NA" :item.date
        case 2:
            self.keyLbl.text   = Constants.EventDetails.AircraftType.rawValue
            self.valueLbl.text = item.aircraftType?.isEmpty ?? true ? "NA" :item.aircraftType
        case 3:
            self.keyLbl.text   = Constants.EventDetails.Tail.rawValue
            self.valueLbl.text = item.tail?.isEmpty ?? true ? "NA" :item.tail
        case 4:
            self.keyLbl.text   = Constants.EventDetails.Departure.rawValue
            self.valueLbl.text = item.departure?.isEmpty ?? true ? "NA" :item.departure
        case 5:
            self.keyLbl.text   = Constants.EventDetails.Destination.rawValue
            self.valueLbl.text = item.destination?.isEmpty ?? true ? "NA" :item.destination
        case 6:
            self.keyLbl.text   = Constants.EventDetails.Time_Depart.rawValue
            self.valueLbl.text = item.timeDepart?.isEmpty ?? true ? "NA" :item.timeDepart
        case 7:
            self.keyLbl.text   = Constants.EventDetails.Time_Arrive.rawValue
            self.valueLbl.text = item.timeArrive?.isEmpty ?? true ? "NA" :item.timeArrive
        case 8:
            self.keyLbl.text   = Constants.EventDetails.DutyID.rawValue
            self.valueLbl.text = item.dutyID?.isEmpty ?? true ? "NA" :item.dutyID
        case 9:
            self.keyLbl.text   = Constants.EventDetails.DutyCode.rawValue
            self.valueLbl.text = item.dutyCode?.isEmpty ?? true ? "NA" :item.dutyCode
        case 10:
            self.keyLbl.text   = Constants.EventDetails.Captain.rawValue
            self.valueLbl.text = item.captain?.isEmpty ?? true ? "NA" :item.captain
        case 11:
            self.keyLbl.text   = Constants.EventDetails.FirstOfficer.rawValue
            self.valueLbl.text = item.firstOfficer?.isEmpty ?? true ? "NA" :item.firstOfficer
        case 12:
            self.keyLbl.text   = Constants.EventDetails.FlightAttendant.rawValue
            self.valueLbl.text = item.flightAttendant?.isEmpty ?? true ? "NA" :item.flightAttendant
            
        default:
            self.keyLbl.text   = "="
            self.valueLbl.text = "="
        }
//        for (index,dt) in  item.dictionary.enumerated(){
//            if index == item.index{
//                self.keyLbl.text = dt.key
//                self.valueLbl.text = dt.value as? String
//            }
//        }
    }

    func updatePointersToData(section: Int, row: Int, pageUpdate: PageUpdateable) {
        //
    }
}

