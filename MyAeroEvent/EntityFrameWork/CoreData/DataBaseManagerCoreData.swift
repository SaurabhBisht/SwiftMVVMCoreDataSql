//
//  DataBaseManagerCoreData.swift
//  MyAeroEvent
//
//  Created by FAB on 31/08/2021.
//

import Foundation
import UIKit


class DataBaseManagerCoreData
{
    var eventViewModel = EventModel.Create.ViewModel()
    var coreDataEventEntries: [Event] = []
    
    init(){
    }
    
    
    func insert(viewModel: EventModel.Create.ViewModel){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let eventCoreData = Event(context: context)
            eventCoreData.aircraftType = viewModel.aircraftType
            eventCoreData.captain = viewModel.captain
            eventCoreData.date =  viewModel.date
            eventCoreData.departure = viewModel.departure
            eventCoreData.destination = viewModel.destination
            eventCoreData.dutyCode = viewModel.dutyCode
            eventCoreData.dutyID =  viewModel.dutyID
            eventCoreData.firstOfficer = viewModel.firstOfficer
            eventCoreData.flightAttendant = viewModel.flightAttendant
            eventCoreData.flightnr = viewModel.flightnr
            eventCoreData.tail = viewModel.tail
            eventCoreData.time_Arrive = viewModel.timeArrive
            eventCoreData.time_Depart = viewModel.timeDepart
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
        }
    }
    
    
    func read() -> [EventModel.Create.ViewModel]  {
        //COREDATA
        var eventFromCoreData = EventModel.Create.ViewModel()
        var viewModel : [EventModel.Create.ViewModel] = []
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let eventsfromCoreData = try? context.fetch(Event.fetchRequest()) as? [Event]{
                coreDataEventEntries =  eventsfromCoreData ?? [Event]()
            }
            
            for (_,dt) in coreDataEventEntries.enumerated(){
                
                eventFromCoreData.aircraftType = dt.aircraftType
                eventFromCoreData.captain = dt.captain
                eventFromCoreData.date =  dt.date
                eventFromCoreData.departure = dt.departure
                eventFromCoreData.destination = dt.destination
                eventFromCoreData.dutyCode = dt.dutyCode
                eventFromCoreData.dutyID =  dt.dutyID
                eventFromCoreData.firstOfficer = dt.firstOfficer
                eventFromCoreData.flightAttendant = dt.flightAttendant
                eventFromCoreData.flightnr = dt.flightnr
                eventFromCoreData.tail = dt.tail
                eventFromCoreData.timeArrive = dt.time_Arrive
                eventFromCoreData.timeDepart = dt.time_Depart
                
                viewModel.append(eventFromCoreData)
            }
        }
        return viewModel
    }
}
