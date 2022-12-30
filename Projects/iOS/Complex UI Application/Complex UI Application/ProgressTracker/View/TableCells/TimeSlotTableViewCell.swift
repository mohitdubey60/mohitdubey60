//
//  TimeSlotTableViewCell.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 22/08/22.
//

import UIKit

class TimeSlotTableViewCell: UITableViewCell {
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hourMinLabel: UILabel!
    
    var timeSlot: TimeSlot!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView() {
        if let ts = timeSlot {
            let diff = Date.diffInMinutes(startTimeInterval: Int(ts.startTime), endTimeInterval: Int(ts.endTime))
            dayNameLabel.text = ts.dayName
            timeLabel.text = "\(diff ?? 0) mins"
            hourMinLabel.text = "\(Date(timeIntervalSince1970: TimeInterval(ts.startTime)).currentTime) - \(Date(timeIntervalSince1970: TimeInterval(ts.endTime)).currentTime)"
        }
    }
    
    func displayData(timeSlot: TimeSlot) {
        self.timeSlot = timeSlot
        updateView()
    }
}
