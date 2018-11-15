//
//  ViewController.swift
//  calendarApp
//
//  Created by Aaron Dougher on 10/12/18.
//  Copyright © 2018 Erin Dougher. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {

    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    
    // Text Color for InMonth, OutMonth, and Current Month
    
    let outSideMonthColor = UIColor.gray
    let currentMonthColor = UIColor.white
    let selectedMonthColor = UIColor.orange
    let currentDateSelectedColor = UIColor.red
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupCalendar()

        
    }
    
    func setupCalendar() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? customCell else {return}
        
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
        
        
        // Remember to un-force unwrap
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate = formatter.date(from: "2019 12 31")
        
        
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
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

    //current calendar as index
    print (calendar.currentSection())

    formatter.locale = Locale(identifier: "en_US")

    //getting current date as string
    print(formatter.string(from: date))

    //calendarView.reloadData()

        
    }
}
