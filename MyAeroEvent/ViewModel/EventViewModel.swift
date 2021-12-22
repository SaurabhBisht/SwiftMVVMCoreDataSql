//
//  EventViewModel.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import Foundation
import UIKit
class EventViewModel : NSObject {
    
    var database:DataBaseManager = DataBaseManager()
    var databaseCoreData:DataBaseManagerCoreData = DataBaseManagerCoreData()
    var dateArray = [String]()
    
    private var serviceHelper : ServiceHelper!
    var sortedEventDictionary = [String:Any]()
    
    var bindEEventViewModelToController : (() -> ()) = {}
    var eventViewModel = [EventModel.Create.ViewModel()]{
        didSet{
            DispatchQueue.main.async {
            self.bindEEventViewModelToController()
            }
        }
    }
   
    var sortedEventViewModel = [String:Any]()
    
    enum PasswordError: Error {
        case short
        case obvious
        case simple
        case simple1
    }

    func showOld(error: PasswordError) {
        switch error {
        case .short:
            print("Your password was too short.")
        case .obvious:
            print("Your password was too obvious.")
            @unknown default:
            print("Your password was too simple.")
        }
    }

    override init() {
        super.init()
        self.serviceHelper = ServiceHelper()
        checkConnectivityAndCallService()
    }
    
    /// Chect for Coinnectivity
    /// Calls Event Service
    /// For offline Reads from SQLite DB
    fileprivate func checkConnectivityAndCallService() {
        if ConnectionManager.shared.hasConnectivity(){
            callFuncToGetEmpData()
        }else{
           dateArray = []
            
            // READ FROM DB
            self.readFromDataBase()

            eventViewModel.forEach({ (data) in
                dateArray.append(data.date ?? "NA")
            })
            
            self.dateArray = self.dateArray.uniqued()
            self.eventViewModel = unique(events: self.eventViewModel)
            
            
        }
    }
    
    
    func unique(events: [EventModel.Create.ViewModel]) -> [EventModel.Create.ViewModel] {

        var uniqueEvents = [EventModel.Create.ViewModel]()

        for event in events {
            if !uniqueEvents.contains(event) {
                uniqueEvents.append(event)
            }
        }

        return uniqueEvents
    }
    
    /// Event Service Call
    func callFuncToGetEmpData() {
        let req = EventModel.Create.Request()
         dateArray = []
            serviceHelper.callService(url: Constants.API.GET_FLIGHT_LEAD, request: req, serviceType: Constants.ServiceType.GET) { (response, error) in
                var eventResponse = EventModel.Create.Response()
                eventResponse.viewModel.removeAll()
  
                for elem in response{
                   // let el = elem as? [String: Any]
                    var event = EventModel.Create.ViewModel()
                    
                    self.populateViewModel(&event, elem)
                    self.prepareForEmptyData(&event)
                    
                    eventResponse.viewModel.append(event)
                  
                    DispatchQueue.main.async {
                    // INSERT TO DB
                    self.insertToDB(event)
                    }
                    
                    self.dateArray.append(event.date ?? "NA")
                }
                
                self.eventViewModel = eventResponse.viewModel
                self.dateArray = self.dateArray.uniqued()
                //self.createDictionaryFromArrayOfData(dateArray: dateArray)
                
            }
        
    }
    
    
    /// Check For Empty Data
    /// Replace Empty by NA
    fileprivate func prepareForEmptyData(_ event: inout EventModel.Create.ViewModel) {
        event.flightnr          = event.flightnr?.isEmpty ?? true ? "NA" : event.flightnr
        event.date              = event.date?.isEmpty ?? true ? "NA" : event.date
        event.aircraftType      = event.aircraftType?.isEmpty ?? true ? "NA" : event.aircraftType
        event.tail              = event.tail?.isEmpty ?? true ? "NA" : event.tail
        event.departure         = event.departure?.isEmpty ?? true ? "NA" : event.departure
        event.destination       = event.destination?.isEmpty ?? true ? "NA" : event.destination
        event.timeDepart       = event.timeDepart?.isEmpty ?? true ? "NA" : event.timeDepart
        event.timeArrive       = event.timeArrive?.isEmpty ?? true ? "NA" : event.timeArrive
        event.dutyID            = event.dutyID?.isEmpty ?? true ? "NA" : event.dutyID
        event.captain           = event.captain?.isEmpty ?? true ? "NA" : event.captain
        event.firstOfficer      = event.firstOfficer?.isEmpty ?? true ? "NA" : event.firstOfficer
        event.flightAttendant   = event.flightAttendant?.isEmpty ?? true ? "NA" : event.flightAttendant
        event.dutyCode          = event.dutyCode?.isEmpty ?? true ? "NA" : event.dutyCode
    }
    
    /// Populate models objects
    /// Data from Service
    fileprivate func populateViewModel(_ event: inout EventModel.Create.ViewModel, _ elem: EventModel.Create.ViewModel) {
        event.flightnr          = elem.flightnr // JsonHelper.getElement(el?["Flightnr"])
        event.date              = elem.date //JsonHelper.getElement(el?["Date"])
        event.aircraftType      = elem.aircraftType //JsonHelper.getElement(el?["AircraftType"])
        event.tail              = elem.tail //JsonHelper.getElement(el?["Tail"])
        event.departure         = elem.departure //JsonHelper.getElement(el?["Departure"])
        event.destination       = elem.destination //JsonHelper.getElement(el?["Destination"])
        event.timeDepart        = elem.timeDepart //JsonHelper.getElement(el?["Time_Depart"])
        event.timeArrive        = elem.timeArrive//JsonHelper.getElement(el?["Time_Arrive"])
        event.dutyID            = elem.dutyID//JsonHelper.getElement(el?["DutyID"])
        event.captain           = elem.captain//JsonHelper.getElement(el?["Captain"])
        event.firstOfficer      = elem.firstOfficer//JsonHelper.getElement(el?["FirstOfficer"])
        event.flightAttendant   = elem.flightAttendant//JsonHelper.getElement(el?["FlightAttendant"])
        event.dutyCode          = elem.dutyCode//JsonHelper.getElement(el?["DutyCode"])
    }
    
    fileprivate func insertToDB(_ event: EventModel.Create.ViewModel) {
        switch PropertyReader.instance.read(propertyName: "DBTYPE").uppercased() {
        case "SQL" : self.database.insert(viewModel: event)
        case "CORE": self.databaseCoreData.insert(viewModel: event)
        default:
            self.database.insert(viewModel: event)
        }
    }
    
    fileprivate func readFromDataBase() {
        //SQLLITE
        switch PropertyReader.instance.read(propertyName: "DBTYPE").uppercased() {
        case "SQL" : self.eventViewModel = self.database.read()
        case "CORE": self.eventViewModel = self.databaseCoreData.read()
        default:
            self.eventViewModel = self.database.read()
        }
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
