//
//  ImageLabelTableViewCell.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 08/08/22.
//

import UIKit

class ImageLabelTableViewCell: UITableViewCell {
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var title: UILabel!
    var controller: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
