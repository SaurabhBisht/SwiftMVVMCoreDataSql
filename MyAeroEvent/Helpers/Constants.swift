//
//  Constants.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//


import UIKit

class Constants {
    
    struct API {
        static let GET_FLIGHT_LEAD = "/wp-content/uploads/dummy-response.json"
    }

    struct SettingNames {
        static let BASE_URL = "base.url"
    }
    
    struct Values {
        static let SUCCESS = "success"
        static let FAILURE = "failure"
        
    }
    
    struct ServiceType {
        static let GET = "GET"
        static let POST = "POST"
        
    }
    
    struct errorMessage {
        static let Response_Is_Null = "System is not available."
        static let Response_Is_Null_Code = "NULL"
    }
    
    struct DutyCode {
        static let FLIGHT = "FLIGHT"
        static let OFF = "OFF"
        static let POSITIONING = "POSITIONING"
        static let STANDBY = "Standby"
        static let LAYOVER = "LAYOVER"
    }
    
    enum EventDetails: String, CaseIterable {
        case Flightnr       = "Flight NR"
        case Date           = "Date"
        case AircraftType   = "Aircraft Type"
        case Tail           = "Tail"
        case Departure      = "Departure"
        case Destination    = "Destination"
        case Time_Depart    = "Time Depart"
        case Time_Arrive    = "Time Arrive"
        case DutyID         = "Duty Id"
        case DutyCode       = "Duty Code"
        case Captain        = "Captain"
        case FirstOfficer   = "First Officer"
        case FlightAttendant = "Flight Attendant"
    }
    
    struct QueryString {
        static let  CREATE = "CREATE TABLE IF NOT EXISTS Event(flightnr TEXT, dt TEXT, aircraftType TEXT, tail TEXT, departure TEXT, destination TEXT, time_Depart TEXT, time_Arrive TEXT, dutyID TEXT, dutyCode TEXT, captain TEXT, firstOfficer TEXT, flightAttendant TEXT);"
        static let  INSERT = "INSERT INTO Event (flightnr, dt, aircraftType, tail, departure, destination, time_Depart, time_Arrive, dutyID, dutyCode, captain, firstOfficer, flightAttendant) VALUES (?, ?, ?,?, ?, ?,?, ?, ?,?, ?, ?,?);"
        static let  DELETE = "Delete from Event;"
        static let  READ   = "SELECT * FROM Event;"
        static let  TABLE_EXISTS = "SELECT name FROM sqlite_master WHERE type='table' AND name='{Event}';"
    }
    
    enum NOTIFICATION_NAMES: String , CaseIterable{
        case LOADING     = "LOADING"
    
    }
}

