//
//  JsonHelper.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//


import Foundation

public class JsonHelper{
    
    public static func convertToJson(data: [String: Any])->String{
        var jsonData=""
        do {
            let postData : Data = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            jsonData = String(data: postData, encoding: String.Encoding.utf8)! as String
            
        } catch let error {
            print(error)
        }
        return jsonData
    }
    
    public static func convertToJson(data: [[String: Any]])->String{
//        var jsonData=""
        do {
            let postData : Data = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let JSONString = String(data: postData, encoding: String.Encoding.utf8) {
               //print(JSONString)
                return JSONString
            }
            
        } catch let error {
            print(error)
        }
        return ""
    }
    
    public static func convertJsonToData(jsonString: String)->Data!{
        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false){
            return dataFromString
        }
        return nil
    }
    
    public static func convertJsonToData(jsonData: [String: Any]?)->Data!{
        if let resp = jsonData {
            do {
                if let postData = try JSONSerialization.data(withJSONObject: resp, options: JSONSerialization.WritingOptions.init(rawValue: 0)) as? Data {
                    return postData
                }
            } catch let error {
                print(error)
            }
        }
        return nil
    }

    public  static func getElement<T>(_ dicxElement:Any?)->T?{
        //var str:T?
        if let elem = dicxElement {
            if !(elem is NSNull) {
                return (dicxElement  as? T)!
            }
        }
        return  nil //str! //str!
    }
}
