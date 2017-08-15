//
//  Core.swift
//  Hillo
//
//  Created by Armin on 8/12/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import Foundation
import UIKit

class Core {

    private var _userName = "Email"
    private var _password = "Password"
    
    var username: String {
        get {
            return _userName
        }
        set {
            _userName = newValue
        }
    }
    
    var password: String {
        get {
            return _password
        }
        set {
            _password = newValue
        }
    }
    
    
    
}
