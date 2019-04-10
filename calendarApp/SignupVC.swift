//
//  SignupVC.swift
//  calendarApp
//
//  Created by Aaron Dougher on 3/2/19.
//  Copyright © 2019 Erin Dougher. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignupVC:UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    @IBAction func continueButton(_ sender: Any) {
        handleSignIn()
    }
    
    func handleSignIn() {
        guard let username = usernameField.text else {return}
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User created")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        
    }
    
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
