//
//  Event+CoreDataProperties.swift
//  
//
//  Created by FAB on 31/08/2021.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var aircraftType: String?
    @NSManaged public var captain: String?
    @NSManaged public var date: String?
    @NSManaged public var departure: String?
    @NSManaged public var destination: String?
    @NSManaged public var dutyCode: String?
    @NSManaged public var dutyID: String?
    @NSManaged public var firstOfficer: String?
    @NSManaged public var flightAttendant: String?
    @NSManaged public var flightnr: String?
    @NSManaged public var tail: String?
    @NSManaged public var time_Arrive: String?
    @NSManaged public var time_Depart: String?

}
