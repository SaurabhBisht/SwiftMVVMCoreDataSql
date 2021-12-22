//
//  ServiceRouter.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import Alamofire
import SwiftyJSON
import UIKit
import UserNotifications

public enum ServiceRouter: URLRequestConvertible {
    static var baseURL = PropertyReader.instance.read(propertyName: Constants.SettingNames.BASE_URL)
    case invokeGet(request: String?, op: String)
    
    var method: HTTPMethod {
        switch self {
        case .invokeGet:
            return .post
        }
    }
    
    
    var path: String {
        switch self {
        case .invokeGet:
            return ""
        }
    }
    
    private func setupHeaders(urlRequest: URLRequest, op: String)->[String:String]{
        var headers = [String:String]()
        headers["Authorization"] = ""
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        
        return headers
    }
    
    
    // MARK: URLRequestConvertible
    
    public func asURLRequest() throws -> URLRequest {
        let urlStr =  "\(ServiceRouter.baseURL)"
        //let url = try urlStr.asURL()
        var baseURL = URL(string: urlStr)
        do {
            baseURL = try urlStr.asURL()
        } catch {
            return URLRequest(url: baseURL!)
        }
        guard let url = baseURL else {
            return URLRequest(url: baseURL!)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .invokeGet(let request, _):
            if let reqStr = request {
                _ = reqStr
                    urlRequest.httpMethod = "GET"
            }
        }
        
        return urlRequest
    }
}
