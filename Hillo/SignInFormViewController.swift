//
//  SignInFormViewController.swift
//  Hillo
//
//  Created by Armin on 8/10/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase

class SignInFormViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isExist = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func signInStart() {
        if let email = userEmail.text, let pass = userPassword.text {
            if userPassword.text == userPassword.text {
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        //Check fucntion for error
                        self.isExist = true
                        self.startSignIn()
                    } else {
                        print(user!.email!)
                        self.isExist = false
                        
                    }
                })
            }
        }
    }
    
    
    @IBAction func startSignIn() {
        if userEmail.text == "", userPassword.text == "" {
            showAlretMessage("Oooops", messge: "Email or Password field shouldn't be empty")
        } else if userPassword.text == "" {
            showAlretMessage("Oooops", messge: "Password is not correct please try again")
        } else if userEmail.text == "" {
            showAlretMessage("Oooops", messge: "Email field shouldn't be empty")
        } else if isExist != false {
            showAlretMessage("Oooops", messge: "User is not exist or password is invalid please try again")
            self.isExist = !self.isExist
        } else {
            signInStart()

        }
    }
    
    func showAlretMessage(_ title: String, messge: String) {
        let alert = UIAlertController(title: title, message: messge, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
