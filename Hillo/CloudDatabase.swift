//
//  CloudDatabase.swift
//  Hillo
//
//  Created by Armin on 8/16/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import Foundation
import Firebase

class CloudDatabase {
    private static let _instance = CloudDatabase()
    
    static var Instance: CloudDatabase {
        return _instance
    }
    
    var dbRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return dbRef.child(Constants.EMAIL)
    }
    
    var storageRef: StorageReference {
        return Storage.storage().reference()
    }
    
//    var imageref: StorageReference {
//        return storageRef.child("\(Constants.IMAGE_STORAGE)")
//    }
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password, Constants.isValid: true]
        usersRef.child(withID).child(Constants.DATA).setValue(data)
    }
 
    
    
    
}
