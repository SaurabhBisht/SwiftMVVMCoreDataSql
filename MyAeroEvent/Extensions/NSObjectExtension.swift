//
//  NSObjectExtension.swift
//  MyAeroEvent
//
//  Created by Saurabh Bisht on 27/08/2021.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

