//
//  UploadImage.swift
//  Hillo
//
//  Created by Armin on 8/17/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import Foundation
import Firebase


class UploadImage {
    static let _instance = UploadImage()
    
    static var Instance: UploadImage {
        return _instance
    }
    
    func sendMedia(image: Data?) {
        if image != nil {
            let uploadMetadata = StorageMetadata()
            uploadMetadata.contentType = "image/jpeg"
            CloudDatabase.Instance.storageRef.child("\(Constants.IMAGE_STORAGE)" + "\(NSUUID().uuidString).jpg").putData(image!, metadata: uploadMetadata) {
                (metadata: StorageMetadata?, err: Error?) in
                if err != nil {
                    print(err!.localizedDescription)
                    return
                } else {
                    print(metadata!)
                    let loggedInUser = Auth.auth().currentUser
                    let key = CloudDatabase.Instance.dbRef.child(Constants.EMAIL).child(loggedInUser!.uid).child(Constants.DATA).childByAutoId().key
                    
                    let download = metadata?.downloadURL()
                    
                    let image = [Constants.URL: download?.absoluteString]
                    let childUpdate = ["/\(Constants.EMAIL)/\(loggedInUser!.uid)/\(Constants.IMAGES)/\(key)": image]
                    CloudDatabase.Instance.dbRef.updateChildValues(childUpdate)
                    print(download?.absoluteString ?? "")
                }
            }
        }
    }
    
    
    
}
