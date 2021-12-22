//
//  PropertyReader.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import Foundation
import SwiftyJSON

class PropertyReader{

    static let instance = PropertyReader()
    
    private var dict:NSDictionary?
    
    init(fileName: String){
        let plistPath = Bundle.main.path(forResource: "Configuration", ofType: "plist")!
        dict = NSDictionary(contentsOfFile: plistPath)
    }
    
    init(){
        let plistPath = Bundle.main.path(forResource: "Configuration", ofType: "plist")!
        dict = NSDictionary(contentsOfFile: plistPath)
    }
    
    func read(propertyName:String)->String{
        
        return dict!.object(forKey: propertyName) as! String
    }

}

