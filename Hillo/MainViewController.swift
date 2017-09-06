//
//  MainViewController.swift
//  Hillo
//
//  Created by Armin on 8/21/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class MainViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var signOut: UIButton!
    

    var userNameText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = Auth.auth().currentUser?.uid
        CloudDatabase.Instance.usersRef.child(userID!).child(Constants.DATA).child(Constants.USERNAME).observeSingleEvent(of: .value, with: { (snapshot) in
            if let snap = snapshot.value as? String {
            print(snap)
                self.userNameLabel.text = snap
            }
        })
//        userNameLabel.text = userNameText
    }

   
    @IBAction func signOut(_ sender: Any) {
        
        SignOut().signOut()
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
