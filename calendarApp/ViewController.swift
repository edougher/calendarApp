//
//  ViewController.swift
//  calendarApp
//
//  Created by Aaron Dougher on 10/12/18.
//  Copyright © 2018 Erin Dougher. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var dayWasTapped: customCell!
    
    var selectedDay: String!
    
 
    
    
    // Text Color for InMonth, OutMonth, and Current Month
    
    let outSideMonthColor = UIColor.gray
    let currentMonthColor = UIColor.white
    let selectedMonthColor = UIColor.black
    let currentDateSelectedColor = UIColor.red
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupCalendar()
        labelSetup()

    }
    
    // Sets up UILabels to current month/year on initial load
    func labelSetup(){
        
        let currentMonthFormatter = DateFormatter()
        let currentYearFormatter = DateFormatter()
        currentMonthFormatter.dateFormat = "MMMM"
        currentYearFormatter.dateFormat = "yyyy"
        let todaysMonth = currentMonthFormatter.string(from: Date())
        let todaysYear = currentYearFormatter.string(from: Date())
        
        self.month.text = todaysMonth
        self.year.text = todaysYear
    }
    
    func setupCalendar() {
        
       calendarView.minimumLineSpacing = 0
       calendarView.minimumInteritemSpacing = 0
        
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? customCell else {return}
        
      // let currentDayFormatter = DateFormatter()
      // currentDayFormatter.dateFormat = "DD"
        
        
        if cellState.isSelected {
            
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = currentMonthColor
            } else {
                validCell.dateLabel.textColor = outSideMonthColor
            }
        }
    }

}

extension ViewController: JTAppleCalendarViewDataSource{
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let currentDate = Date()
        let startDate = currentDate
        let endDate = formatter.date(from: "2019 12 31")
    
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate!)
        return parameters
    }
}
   

extension ViewController: JTAppleCalendarViewDelegate {

    //Display Cell
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customCell

        myCustomCell.dateLabel.text = cellState.text
        
        
        
        if cellState.isSelected {
            myCustomCell.selectedView.isHidden = false
            
        } else {
            myCustomCell.selectedView.isHidden = true
        }
        
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        
        return myCustomCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    
     _ = cell as! customCell
        
    }
    
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        
        
       guard let validCell = cell as? customCell else {return}
        
        handleCellTextColor(view: cell, cellState: cellState)
        
        validCell.selectedView.isHidden = false

        formatter.dateFormat = "MMMM dd"
        let currentDay = formatter.string(from: date)
    
        self.selectedDay = currentDay
        performSegue(withIdentifier: "toHrsVC", sender: self)
        
        print(currentDay)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let hrsVC = segue.destination as? hoursViewController else {return}
        hrsVC.dateLbl = self.selectedDay
        }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
            
            
        guard let validCell = cell as? customCell else {return}
        
        handleCellTextColor(view: cell, cellState: cellState)
        
        validCell.selectedView.isHidden = true
        
        
        
        
        }
    

    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)
        
    }
    
    @IBAction func didUnwindFromViewController(_ sender:UIStoryboardSegue) {}
    
    
}
