//
//  DataBaseManager.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 28/08/2021.
//

import Foundation
import SQLite3

class DataBaseManager
{
    
    init(){
        dataBase = openDatabase()
        createTable()
    }
    
    let dbPath: String = "myDb.sqlite"
    var dataBase:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func tableExists()->Bool {
        let tableExistsStatement = Constants.QueryString.TABLE_EXISTS
        var tableExistsStat: OpaquePointer? = nil
        var found = false
        
        if sqlite3_prepare_v2(dataBase, tableExistsStatement, -1, &tableExistsStat, nil) == SQLITE_OK {
            
            if sqlite3_step(tableExistsStat) == SQLITE_DONE {
                print("Table found")
                found = true
            } else {
                print("Table not found.")
            }
        }
        else {
            print("Error!")
        }
        sqlite3_finalize(tableExistsStat)
        return found
    }
    
    func deleteAllRows() {
        if tableExists(){
            
            let deleteStatement = Constants.QueryString.DELETE
            var delteSt: OpaquePointer? = nil
            if sqlite3_prepare_v2(dataBase, deleteStatement, -1, &delteSt, nil) == SQLITE_OK {
                
                if sqlite3_step(delteSt) == SQLITE_DONE {
                    print("Successfully Deleted")
                } else {
                    print("Could not Delete.")
                }
            }
            else {
                print("Delete statement could not be prepared.")
            }
            sqlite3_finalize(delteSt)
        }
    }
    
    func createTable() {
        let createTableString = Constants.QueryString.CREATE
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(dataBase, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Event table created.")
            } else {
                print("Event table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(viewModel: EventModel.Create.ViewModel)
    {
        
        let insertStatementString = Constants.QueryString.INSERT
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(dataBase, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (viewModel.flightnr as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (viewModel.date as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (viewModel.aircraftType as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (viewModel.tail as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (viewModel.departure as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (viewModel.destination as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (viewModel.timeDepart as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (viewModel.timeArrive as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (viewModel.dutyID as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (viewModel.dutyCode as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, (viewModel.captain as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 12, (viewModel.firstOfficer as NSString? ?? "").utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 13, (viewModel.flightAttendant as NSString? ?? "").utf8String, -1, nil)
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    func read() -> [EventModel.Create.ViewModel] {
        let queryStatementString = Constants.QueryString.READ
        var queryStatement: OpaquePointer? = nil
        var viewModel : [EventModel.Create.ViewModel] = []
        if sqlite3_prepare_v2(dataBase, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
               
                let flightnr        = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let date            = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let aircraftType    = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let tail            = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let departure       = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let destination     = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let time_Depart     = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let time_Arrive     = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let dutyID          = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let dutyCode        = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let captain         = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let firstOfficer    = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
                let flightAttendant = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
                
               viewModel.append(EventModel.Create.ViewModel(flightnr: flightnr, date: date, aircraftType: aircraftType, tail: tail, departure: departure, destination: destination, timeDepart: time_Depart, timeArrive: time_Arrive, dutyID: dutyID, dutyCode: dutyCode, captain: captain, firstOfficer: firstOfficer, flightAttendant: flightAttendant))
              
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return viewModel
    }
    
}

