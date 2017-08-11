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
                    self.isExist = true
                } else {
                    print(user!.email!)
                    self.isExist = false
                }
            })
            }
        }
//        isExist = !isExist
    }
    
    
    
    @IBAction func startSignUp() {
        if emailText.text == "", passwordText.text == "" {
            alertPop()
        } else if passwordText.text == "" {
            passEmptyAlert()
        } else if emailText.text == "" {
            emailEmptyAlert()
        } else if passwordText.text != rePasswordText.text {
            passNotMatchAlert()
        } else if self.isExist != false {
            userExistError()
        } else {
            signUpStart()
        }
    }
    
    
    func alertPop() {
        let alert = UIAlertController(title: "Ooops", message: "Email or Password field shouldn't be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func passEmptyAlert() {
        let alert = UIAlertController(title: "Ooops", message: "Password field shouldn't be empty or need to be at least 6 characters", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func emailEmptyAlert() {
        let alert = UIAlertController(title: "Ooops", message: "Email field shouldn't be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func passNotMatchAlert() {
        let alert = UIAlertController(title: "Ooops", message: "password are not match please check them again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func userExistError() {
        let alert = UIAlertController(title: "Ooops", message: "user already exist with this email", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
