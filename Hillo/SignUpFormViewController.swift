//
//  SignUpFormViewController.swift
//  Hillo
//
//  Created by Armin on 8/10/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase

class SignUpFormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    let PROFILE_SEGUE = "FromSignUp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 300, height: 300)
        emailText.delegate = self
        passwordText.delegate = self
        
    }
    
    
    @IBAction func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startSignUp() {
        if emailText.text != "" && passwordText.text != "" {
            AuthPro.Instance.signUp(withEmail: emailText.text!, withPassword: passwordText.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.showAlretMessage("Problem With Creating A New User", messge: message!)
                } else {
                    self.performSegue(withIdentifier: self.PROFILE_SEGUE, sender: nil)
                }
            })
        } else {
            showAlretMessage("Email And Password Are Required", messge: "Please enter email and password")
        }
        
    }
    func showAlretMessage(_ title: String, messge: String) {
        let alert = UIAlertController(title: title, message: messge, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
 
}
