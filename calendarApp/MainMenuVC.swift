//
// MainMenuVC.swift
//  calendarApp
//
//  Created by Aaron Dougher on 3/1/19.
//  Copyright © 2019 Erin Dougher. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MainMenuVC: UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toCalendarVC", sender: self)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}
