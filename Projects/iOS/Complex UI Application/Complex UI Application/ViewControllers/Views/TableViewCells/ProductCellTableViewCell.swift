    //
    //  ProductCellTableViewCell.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 09/08/22.
    //

import UIKit
import Combine

class ProductCellTableViewCell: UITableViewCell {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var expandShrinkImage: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    var cancellable: AnyCancellable?
    var product: DummyProductModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
            // Configure the view for the selected state
    }
    
    private func updateData() {
        if let urlString = product.thumbnail, let url = URL(string: urlString) {
            cancellable = ImageLoader.shared.loadImage(from: url)
                .sink {[weak self] image in
                    self?.bannerImageView.image = image
                }
            labelTitle.text = product.title
            labelDescription.text = product.productDescription
            labelPrice.text = "$\(product.price ?? 0)"
            labelRating.text = "\(product.rating ?? 0)/5"
            labelDiscount.text = "\(product.discountPercentage ?? 0)%"
        }
    }
    
    func display(data: DummyProductModel) {
        product = data
        updateData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImageView.image = nil
    }
    
}
