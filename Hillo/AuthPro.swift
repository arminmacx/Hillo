//
//  AuthPro.swift
//  Hillo
//
//  Created by Armin on 8/15/17.
//  Copyright © 2017 Armin. All rights reserved.
//

import Foundation
import Firebase

typealias LoginHandler = (_ msg: String?) -> Void

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid Email Address, Please Provide Valid Email Address"
    static let WRONG_PASSWORD = " Wrong Password, Please Enter Correct Password"
    static let PROBLEM_CONNECTING = " Problem Connecting to Database"
    static let USER_NOT_FOUND = "User Not Found, Please Register"
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please User Another Email"
    static let WEAK_PASSWORD = "Password Should At Least 6 Characters Long"
}


class AuthPro {
    static let _instance = AuthPro()
    
    static var Instance: AuthPro {
        return _instance
    }
    
    func login(withEmail: String, withPassword: String, loginHandler: LoginHandler?) {
        Auth.auth().signIn(withEmail: withEmail, password: withPassword, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
            } else {
                loginHandler?(nil)
            }
        })
    } // SIGN IN FUNC
    
    func signUp(withEmail: String, withPassword: String, loginHandler: LoginHandler?) {
        Auth.auth().createUser(withEmail: withEmail, password: withPassword, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler)
                
            } else {
                if user?.uid != nil {
                    
                    CloudDatabase.Instance.saveUser(withID: user!.uid, email: withEmail, password: withPassword)
                    print(user!.uid)
                    self.login(withEmail: withEmail, withPassword: withPassword, loginHandler: loginHandler)
                }
                
            }
            
        })
    } // SIGN UP FUNC
    
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                return true
            } catch {
                return false
            }
        }
        return true
    } //LOGOUT FUNC
    
    
    func handleErrors(err: NSError, loginHandler: LoginHandler?) {
        if let errCode = AuthErrorCode(rawValue: err.code) {
            
            switch errCode {
            case .wrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD)
                break
            case .invalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL)
                break
            case .userNotFound :
                loginHandler?(LoginErrorCode.USER_NOT_FOUND)
                break
            case .emailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE)
                break
            case .networkError:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING)
                break
            case .weakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD)
                break
            default:
                break
            }
            
        }
    }
    
}
