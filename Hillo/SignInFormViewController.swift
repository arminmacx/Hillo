//
//  SignInFormViewController.swift
//  Hillo
//
//  Created by Armin on 8/10/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

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
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        dismissTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(dismissTap)
        
    }

    @IBAction func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func startSignIn() {
        if userEmail.text != "" && userPassword.text != "" {
            AuthPro.Instance.login(withEmail: userEmail.text!, withPassword: userPassword.text!, loginHandler: { (message) in
                if message != nil {
                    self.showAlertMessage("There Is A Problem With Authentication", message: message!)
                } else {
                    self.CompleteSignIn(id: (Auth.auth().currentUser?.uid)!)
                    self.userPassword.text = ""
                    self.userEmail.text = ""
                    self.performSegue(withIdentifier: self.PROFILE_SEGUE, sender: nil)
                }
            })
        } else {
            showAlertMessage("Email And Password Are Required", message: "Please enter email and password")
 
        }
    }
    
    func showAlertMessage(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        userEmail.resignFirstResponder()
        userPassword.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func CompleteSignIn(id: String) {
        let keyChain = AuthPro().keyChain
        keyChain.set(id, forKey: "uid")
    }


}
