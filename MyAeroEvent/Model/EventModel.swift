//
//  EventModel.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//
import Combine

struct EventModel: Combine.Publisher{
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
        
    }
    
    
    typealias Output =  Void
    typealias Failure = Never
    
    struct Create{
        struct Request {}
        
        struct Response {
            var result: String = ""
            var viewModel = [ViewModel()]
        }
        struct ViewModel: Codable, Equatable {
            var flightnr : String?
            var date : String?
            var aircraftType : String?
            var tail : String?
            var departure : String?
            var destination : String?
            var timeDepart : String?
            var timeArrive : String?
            var dutyID : String?
            var dutyCode : String?
            var captain : String?
            var firstOfficer : String?
            var flightAttendant : String?
            
            enum CodingKeys: String, CodingKey {
                case flightnr = "Flightnr"
                case date = "Date"
                case aircraftType = "Aircraft Type"
                case tail = "Tail"
                case departure = "Departure"
                case destination = "Destination"
                case timeDepart = "Time_Depart"
                case timeArrive = "Time_Arrive"
                case dutyID = "DutyID"
                case dutyCode = "DutyCode"
                case captain = "Captain"
                case firstOfficer = "First Officer"
                case flightAttendant = "Flight Attendant"
                
            }
            
            static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
                return "\(lhs.departure ?? "")-\(lhs.timeArrive ?? "")" == "\(rhs.departure ?? "")-\(rhs.timeArrive ?? "")"
            }
        }
    }
}

