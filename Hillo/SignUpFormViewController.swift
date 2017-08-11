//
//  SignUpFormViewController.swift
//  Hillo
//
//  Created by Armin on 8/10/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase

class SignUpFormViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var rePasswordText: UITextField!
    
    var isExist = false
    var userName: String!
    var firebaseUser: String!
    var userEmail: String!
    var userPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func signUpStart() {
        if let email = emailText.text, let pass = passwordText.text {
            if passwordText.text == rePasswordText.text {
            Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    //Call function to check errors
                    self.isExist = true
                    self.startSignUp()
                } else {
                    print(user!.email!)
                    //Call Fucntion to check errors
                    self.isExist = false
                    
                }
            })
            }
        }
    }
    
    
    
    @IBAction func startSignUp() {
        if emailText.text == "", passwordText.text == "" {
            showAlretMessage("Oooops", messge: "Email or Password field shouldn't be empty")
        } else if passwordText.text == "" {
            showAlretMessage("Oooops", messge: "Password field shouldn't be empty or need to be at least 6 characters")
        } else if emailText.text == "" {
            showAlretMessage("Oooops", messge: "Email field shouldn't be empty")
        } else if passwordText.text != rePasswordText.text {
            showAlretMessage("Ooops", messge: "password are not match please check them again")
        } else if self.isExist != false {
            showAlretMessage("Ooops", messge: "user already exist with this email")
            self.isExist = !self.isExist
        }else {
            signUpStart()
        }
    }
    
    func showAlretMessage(_ title: String, messge: String) {
        let alert = UIAlertController(title: title, message: messge, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
