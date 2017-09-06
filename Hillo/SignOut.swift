//
//  SignOut.swift
//  Hillo
//
//  Created by Armin on 9/6/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

class SignOut {

    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        KeychainSwift().delete("uid")
    }
    
    
}
