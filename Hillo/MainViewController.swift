//
//  MainViewController.swift
//  Hillo
//
//  Created by Armin on 8/21/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postView: UIView!
    
    
    var userSelectedImageForUpload: UIImage!
    var userNameText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileImage.image = userSelectedImageForUpload
        userProfileImage.layer.cornerRadius = 50.0
        userProfileImage.clipsToBounds = true
        userProfileImage.layer.borderWidth = 2.0
        userProfileImage.layer.borderColor = UIColor.white.cgColor
        postView.layer.cornerRadius = 15.0
        postView.clipsToBounds = true
        userNameLabel.text = userNameText
    }

}
