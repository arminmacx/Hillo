//
//  ViewController.swift
//  Hillo
//
//  Created by Armin on 8/9/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var LogoText: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var buttonImageSignUp: UIImageView!
    @IBOutlet weak var buttonImageSignIn: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImage.alpha = 0
        LogoText.alpha = 0
        signInButton.alpha = 0
        signUpButton.alpha = 0
        buttonImageSignIn.alpha = 0
        buttonImageSignUp.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, animations: {
            self.backImage.alpha = 1
        }) { (true) in
            self.showTitle()
        }
    }
    
    func showTitle() {
        UIView.animate(withDuration: 1, animations: {
            self.LogoText.alpha = 1
        }, completion: { (true) in
            self.showSignUp()
        })
    }
    
    func showSignUp() {
        UIView.animate(withDuration: 1, animations: {
            self.buttonImageSignUp.alpha = 1
            self.signUpButton.alpha = 1
        }, completion: { (true) in
            self.showSignIn()
        })
        }
        
        func showSignIn() {
            UIView.animate(withDuration: 1, animations: {
                self.buttonImageSignIn.alpha = 1
                self.signInButton.alpha = 1
            })
            
        }
    
    @IBAction func signUpButtonTouched() {
        signUpClicked()
        
    }
    
    @IBAction func signInButtonTouched() {
        signInClicked()
    }
    
    func signInClicked() {
        performSegue(withIdentifier: "SignInForm", sender: nil)
    }
    
    func signUpClicked() {
        
        performSegue(withIdentifier: "SignUpForm", sender: nil)
    }
    
 

        
        
}

