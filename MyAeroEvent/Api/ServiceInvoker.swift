//
//  ServiceInvoker.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import Alamofire
import SwiftyJSON

class ServiceInvoker{

    public static func invokeApi(op: String, request: [String:Any] ,completionHandler: @escaping ([EventModel.Create.ViewModel]?,AppError?)->Void) {
        let sessionManager = Alamofire.SessionManager()
        let queue = DispatchQueue(label: "com.sb.response-queue", qos: .userInitiated, attributes: [.concurrent])
        _ = EventModel.Create.Response()
        sessionManager.session.configuration.urlCache?.removeAllCachedResponses()
        
        let request = JsonHelper.convertToJson(data: request)
        let invokerReq = ServiceRouter.invokeGet(request: request, op: ServiceRouter.baseURL)
        
        sessionManager.request(invokerReq).responseString (queue: queue,completionHandler:{ (response) in
        
            var respStr = ""
            
            if let resp = response.result.value {
                respStr = resp
            }
            
            if response.result.isSuccess {
                
                do{
                    let jsonData = respStr.data(using: .utf8)!
                    
                    let decoder = JSONDecoder()
                   // decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let json = try? decoder.decode([EventModel.Create.ViewModel].self,from: (jsonData))
                    completionHandler(json, nil)
                } catch let error {
                    completionHandler(nil, AppError.defaultError())
                }
                
            }else {
                var err = AppError()
                err.code = Constants.errorMessage.Response_Is_Null_Code
                err.desc = Constants.errorMessage.Response_Is_Null
                completionHandler(nil, err)
            }
            
            sessionManager.session.invalidateAndCancel()
            return
        })
    }

    
    static func clearAllRequests(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}

