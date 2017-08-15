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
    @IBOutlet weak var dismissButton: UIButton!
    
    var isExist = false
    var userName: String!
    var firebaseUser: String!
    var userEmail: String!
    var userPass: String!
    var userUid: String!
    
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
                    print("user \(user!.email!) just signed up")
                    //Call Fucntion to check errors
                    let databaseRef = Database.database().reference()
                    let userRef = databaseRef.child("Users")
                    let refValues = ["email": email, "pass": pass]
                    userRef.updateChildValues(refValues, withCompletionBlock: { (err, databaseRef) in
                        if err != nil {
                            print(err!)
                            return
                        }
                        print("database Created")
                        
                    })
                    self.isExist = false
                    self.userUid = user!.uid
                    self.userName = user!.email
                    self.performSegue(withIdentifier: "FromSignUp", sender: nil)
                }
            })
            }
        }
    }
    
    @IBAction func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromSignUp" {
            let destination: ProfileViewController = segue.destination as! ProfileViewController
            destination.userUid = self.userUid
            destination.userName = self.userName
        }
    }
    
}
