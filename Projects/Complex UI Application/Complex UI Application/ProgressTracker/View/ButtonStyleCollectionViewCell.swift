//
//  ButtonStyleCollectionViewCell.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 12/08/22.
//

import UIKit

class ButtonStyleCollectionViewCell: UICollectionViewCell {
    var title: String!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateViewOnSelectionChanged()
    }
    
    func displayData(title: String) {
        cellTitleLabel.text = title.first?.uppercased()
        updateViewOnSelectionChanged()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTitleLabel.text = title.first?.uppercased()
        updateViewOnSelectionChanged()
    }
    
    func updateViewOnSelectionChanged() {
        if isSelected {
            containerView.backgroundColor = UIColor.tintColor
            cellTitleLabel.textColor = UIColor.white
        } else {
            containerView.backgroundColor = .systemBackground
            cellTitleLabel.textColor = UIColor.tintColor
        }
    }
}
