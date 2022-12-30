//
//  SmallPhotoCollectionViewCell.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 05/08/22.
//

import UIKit

class SmallPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    var photoModel = PhotoModel()
    
    func renderCell() {
        if let data = photoModel.imageData {
            image.image = UIImage(data: data)
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFill
        }
    }
}
