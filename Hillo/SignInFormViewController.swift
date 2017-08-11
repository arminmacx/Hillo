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
                        self.isExist = true
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
            alertPop()
        } else if userPassword.text == "" {
            passEmptyAlert()
        } else if userEmail.text == "" {
            emailEmptyAlert()
        } else if userPassword.text != userPassword.text {
            passNotMatchAlert()
        } else {
            signInStart()

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
        let alert = UIAlertController(title: "Ooops", message: "password is not correct please", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
  
    
    
}
