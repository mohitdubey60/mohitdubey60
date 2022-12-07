    //
    //  ProgressTrackerDashboardViewController.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 12/08/22.
    //

import UIKit
import ADDatePicker

class ProgressTrackerDashboardViewController: UIViewController {
    
    @IBOutlet weak var datePickerHorizontal: ADDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarUI()
    }
    
    private func setupCalendarUI() {
        let year = Calendar.current.component(.year, from: Date())
        datePickerHorizontal.yearRange(inBetween: year, end: year + 10)
        
        datePickerHorizontal.intialDate = Date()
            //set BackGround Color of DatePicker
        datePickerHorizontal.bgColor = .clear
        
            //set Selection and Deselection Background Colors
        
        datePickerHorizontal.deselectedBgColor = .clear
        datePickerHorizontal.selectedBgColor = .red
        
            //set Selection and Deselection Text Colors
        datePickerHorizontal.selectedTextColor = .black
        datePickerHorizontal.deselectTextColor = .lightGray
        datePickerHorizontal.selectionType = .circle
    }
}

extension ProgressTrackerHomeViewController: ADDatePickerDelegate {
    func ADDatePicker(didChange date: Date) {
        print(date)
    }
}
