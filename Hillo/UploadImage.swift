//
//  UploadImage.swift
//  Hillo
//
//  Created by Armin on 8/17/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase


class UploadImage {
    private static let _instance = UploadImage()
    
    static var Instance: UploadImage {
        return _instance
    }
    
    
    
    func sendMedia(image: Data?, progress: UIProgressView, withCompletionHandler:@escaping (Bool) -> Void) {
        if image != nil {
            let uploadMetadata = StorageMetadata()
            uploadMetadata.contentType = "image/jpeg"
            let uploadTask = CloudDatabase.Instance.storageRef.child("\(Constants.IMAGE_STORAGE)" + "\(NSUUID().uuidString).jpg").putData(image!, metadata: uploadMetadata) {
                (metadata: StorageMetadata?, err: Error?) in
                if err != nil {
                    withCompletionHandler(false)
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
            uploadTask.observe(.progress, handler: { (snapshot) in
                let pro = snapshot.progress
                progress.progress = Float((pro?.fractionCompleted)!)
                if pro?.fractionCompleted == 1.0 {
                    withCompletionHandler(true)
                } else {
                    withCompletionHandler(false)
                    return
                }
            })
        }
    }
    
    
}
