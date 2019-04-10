//
//  hoursViewController.swift
//  calendarApp
//
//  Created by Aaron Dougher on 11/16/18.
//  Copyright © 2018 Erin Dougher. All rights reserved.
//

import UIKit
import Firebase

class hoursViewController: UIViewController {
    
    
    @IBOutlet weak var hrsDateLbl: UILabel!
    var dateLbl: String = ""
    
    let hoursOfDay = ["8:00 am", "9:00 am", "10:00 am", "11:00 am", "12:00 pm", "1:00 pm", "2:00 pm", "3:00 pm", "4:00 pm", "5:00 pm", "6:00 pm", "7:00 pm", "8:00 pm"]
    
    
    var ref: DatabaseReference?
    var hours: [DataSnapshot]! = []
    var user: User?
    var _refHandle: DatabaseHandle!
    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    
    

override func viewDidLoad() {
        super.viewDidLoad()
        configureDatabase()

        hrsDateLbl.text = dateLbl
    
    }
    
    
    func configureAuth(){
       
    }
    
    func configureDatabase() {
        ref = Database.database().reference()
    }
    
    deinit {
        
    }


}

extension hoursViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.allowsMultipleSelection = true
        return (hoursOfDay.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customHourCell", for: indexPath)
        cell.textLabel?.text = hoursOfDay[indexPath.row]
        cell.textLabel?.textAlignment = .center
        tableView.rowHeight = 85
    
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     // let cell = tableView.dequeueReusableCell(withIdentifier: "customHourCell")
        
        let cellText = tableView.cellForRow(at: indexPath)
      
        
     //
     // let data = cellText?.textLabel?.text
     //
     // let data = "You selected cell number: \(indexPath.row + 1)!"
     //
     
     // ref.child("hours").childByAutoId().setValue(data)
     //
     // sendInfo(data: "\(String(describing: data))")
    
      //  hrsDateLbl.text = dateLbl
        ref?.child("openings/day").childByAutoId().setValue("\(String(describing: hrsDateLbl.text))")
        ref?.child("openings/hour").childByAutoId().setValue("\(String(describing: cellText!.textLabel!.text))")
        
        
        
        print("You selected cell number: \(indexPath.row + 1)!")
        print(hrsDateLbl.text!)
        print(cellText!.textLabel!.text!)
        
      }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        ref?.child("openings/hour").removeValue()
        ref?.child("openings/day").removeValue()
    }
    
    
     //Send info to database
    func sendInfo() {
        

        
            
        
    
   }
    @IBAction func handleLogOut(_ sender: Any) {
  //     try! Auth.auth().signOut()
  // }
    
    do
    {
    try Auth.auth().signOut()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let introVC = storyBoard.instantiateViewController(withIdentifier: "MainMenuVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = introVC
        
        
    }
    catch let error as NSError
    {
        print (error.localizedDescription)
    }
    
}
}
