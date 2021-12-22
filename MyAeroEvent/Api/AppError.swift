//
//  AppError.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import UIKit

struct AppError{
    var code = ""
    var desc = ""
    
    static func defaultError()->AppError{
      var err = AppError()
      err.code = "ERR_DEFAULT"
      err.desc = Constants.errorMessage.Response_Is_Null
      return err
    }
}

