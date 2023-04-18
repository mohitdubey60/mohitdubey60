//
//  WeekRowTableViewCell.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 10/02/23.
//

import UIKit

class WeekRowTableViewCell: UITableViewCell {

    
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func displayData(title: String, subtitle: String, leftText: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        leftTextLabel.text = leftText
    }
}
