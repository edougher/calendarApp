//
//  loginVC.swift
//  calendarApp
//
//  Created by Aaron Dougher on 3/1/19.
//  Copyright © 2019 Erin Dougher. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class  LoginVC:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    


  
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
    continueButton.isEnabled = true

  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      emailField.becomeFirstResponder()
  }
  
  @IBAction func handleDismissButton(_ sender: Any) {
      self.dismiss(animated: false, completion: nil)
  }
  
  
  /**
   Enables the continue button if the **username**, **email**, and **password** //fields are all non-empty.
  
   - Parameter target: The targeted **UITextField**.
   */
  
  @objc func textFieldChanged(_ target:UITextField) {
      let email = emailField.text
      let password = passwordField.text
      let formFilled = email != nil && email != "" && password != nil && password != ""
      setContinueButton(enabled: formFilled)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  
     //  Resigns the target textField and assigns the next textField in the //form.
  
      switch textField {
      case emailField:
          emailField.resignFirstResponder()
          passwordField.becomeFirstResponder()
          break
      case passwordField:
          handleSignIn()
          break
      default:
          break
      }
      return true
  }
//
  /**
   Enables or Disables the **continueButton**.
   */
//
  func setContinueButton(enabled:Bool) {
      if enabled {
          continueButton.alpha = 1.0
          continueButton.isEnabled = true
      } else {
          continueButton.alpha = 0.5
          continueButton.isEnabled = false
      }
  }
    
    @IBAction func continueButton(_ sender: Any) {
        handleSignIn()
    }
    
  
  @objc func handleSignIn() {
      guard let email = emailField.text else {return}
      guard let password = passwordField.text else {return}
  
    //  setContinueButton(enabled: false)
     // continueButton.setTitle("", for: .normal)
  
      Auth.auth().signIn(withEmail: email, password: password) {
          user, error in
          if error == nil && user != nil {
              self.dismiss(animated: false, completion: nil)
          } else {
              print("Error logging in:  \(error!.localizedDescription)")
              self.resetForm()
          }
  
      }
  
  }
  
  func resetForm() {
      let alert = UIAlertController(title: "Error logging in", message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
  
      setContinueButton(enabled: true)
      continueButton.setTitle("Continue", for: .normal)
  
    }

}

