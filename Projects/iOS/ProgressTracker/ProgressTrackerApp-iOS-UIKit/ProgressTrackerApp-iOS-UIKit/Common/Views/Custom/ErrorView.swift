//
//  ErrorView.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 15/02/23.
//

import UIKit

enum ErrorType {
    case noContent
}

class ErrorView: UIView {
    
    @IBOutlet weak var errorImageView: UIImageView!
    
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    
    @IBOutlet weak var errorActionButton: UIButton!
    
    var completionHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupErrorView(errorType: ErrorType?, errorImage: UIImage?, title: String?, description: String?, actionButtonText: String?, completion: (()->Void)?) {
        if let actionButtonText {
            errorActionButton.setTitle(actionButtonText, for: .normal)
            self.completionHandler = completion
        } else{
            errorActionButton.removeFromSuperview()
        }
        
        if let title {
            errorTitleLabel.text = title
        } else {
            errorTitleLabel.removeFromSuperview()
        }
        
        if let description {
            errorDescriptionLabel.text = description
        } else {
            errorDescriptionLabel.removeFromSuperview()
        }
        
        if let errorImage {
            errorImageView.image = errorImage
        } else if let errorType {
            
        } else {
            errorImageView.removeFromSuperview()
        }
    }
}
