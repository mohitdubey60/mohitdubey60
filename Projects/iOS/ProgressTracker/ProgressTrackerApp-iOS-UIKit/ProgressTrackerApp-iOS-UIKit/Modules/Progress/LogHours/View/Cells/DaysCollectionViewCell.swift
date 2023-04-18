//
//  DaysCollectionViewCell.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 10/02/23.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var backgroundUIVIew: UIView!
    var dayOfWeek: DaysOfWeek = .sunday
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        
    }
    
    override var isSelected: Bool {
        didSet {
            changeColor()
        }
    }
    
    func prepareCellForDisplay(dayOfWeek day: DaysOfWeek) {
        dayOfWeek = day
        cellLabel.text = "\(dayOfWeek.rawValue.first!)"
        
        cornerRadius = floor(bounds.width / 2)
        changeColor()
    }
    
    private func changeColor() {
        UIView.animate(withDuration: 0.2) {[weak self] in
            guard let self else {
                return
            }
            
            if self.isSelected {
                self.backgroundUIVIew.backgroundColor = .darkGray
            } else {
                self.backgroundUIVIew.backgroundColor = .lightGray
            }
        }
    }
}
