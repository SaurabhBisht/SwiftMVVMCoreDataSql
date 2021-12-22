//
//  ServiceHelper.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import Foundation
import SwiftyJSON

public class ServiceHelper{
    func callService(url: String, request: EventModel.Create.Request, serviceType: String?, completionHandler: @escaping ( [EventModel.Create.ViewModel], AppError) -> Void) {
        ServiceInvoker.invokeApi(op: url, request: [:], completionHandler: { (response, error) in
            completionHandler(response ?? [EventModel.Create.ViewModel](), error ?? AppError())
        })
    }
}

