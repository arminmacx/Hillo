//
//  SignInFormViewController.swift
//  Hillo
//
//  Created by Armin on 8/10/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase

class SignInFormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    let PROFILE_SEGUE = "FromSignIn"
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail.delegate = self
        userPassword.delegate = self
    }

    @IBAction func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func startSignIn() {
        if userEmail.text != "" && userPassword.text != "" {
            
            AuthPro.Instance.login(withEmail: userEmail.text!, withPassword: userPassword.text!, loginHandler: { (message) in
                if message != nil {
                    self.showAlretMessage("There Is A Problem With Authentication", messge: message!)
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
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == PROFILE_SEGUE {
//            let destination: ProfileViewController = segue.destination as! ProfileViewController
//
//        }
//    }
    
}
