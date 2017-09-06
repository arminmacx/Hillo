//
//  ViewController.swift
//  Hillo
//
//  Created by Armin on 8/9/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var LogoText: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImage.alpha = 0
        LogoText.alpha = 0
        signInButton.alpha = 0
        signUpButton.alpha = 0
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let keyChain = AuthPro().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "mainView", sender: nil)
        }
        
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
            self.signUpButton.alpha = 1
        }, completion: { (true) in
            self.showSignIn()
        })
        }
        
        func showSignIn() {
            UIView.animate(withDuration: 1, animations: {
                self.signInButton.alpha = 1
            })
            
        }

    @IBAction func signUpButtonTouched() {
        performSegue(withIdentifier: "SignUpForm", sender: nil)
    }
    
    @IBAction func signInButtonTouched() {
        performSegue(withIdentifier: "SignInForm", sender: nil)
    }
    
    
    func CompleteSignIn(id: String) {
        let keyChain = AuthPro().keyChain
        keyChain.set(id, forKey: "uid")
    }

}

