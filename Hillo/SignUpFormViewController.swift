//
//  SignUpFormViewController.swift
//  Hillo
//
//  Created by Armin on 8/10/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class SignUpFormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    
    let PROFILE_SEGUE = "FromSignUp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 300, height: 300)
        emailText.delegate = self
        passwordText.delegate = self
        usernameText.delegate = self
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        dismissTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(dismissTap)
        
    }
    
    
    @IBAction func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startSignUp() {
        if emailText.text != "" && passwordText.text != "" {
            AuthPro.Instance.signUp(withEmail: emailText.text!, withPassword: passwordText.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.showAlertMessage("Problem With Creating A New User", message: message!)
                } else {
                    CloudDatabase.Instance.usersRef.child("\(String(describing: Auth.auth().currentUser!.uid))/\(Constants.DATA)/\(Constants.USERNAME)/").setValue(self.usernameText.text)
                    self.CompleteSignIn(id: (Auth.auth().currentUser?.uid)!)
                    
                    self.usernameText.text = ""
                    self.emailText.text = ""
                    self.passwordText.text = ""
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
        emailText.resignFirstResponder()
        usernameText.resignFirstResponder()
        passwordText.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? MainViewController {
//            destination.userNameText = self.usernameText.text
//        }
//    }
 
    
    func CompleteSignIn(id: String) {
        let keyChain = AuthPro().keyChain
        keyChain.set(id, forKey: "uid")
    }
    



}
