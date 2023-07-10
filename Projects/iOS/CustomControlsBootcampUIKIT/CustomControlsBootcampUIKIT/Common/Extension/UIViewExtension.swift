//
//  UIViewExtension.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 11/05/23.
//

import UIKit

extension UIView {
    var visibleRect: CGRect? {
        guard let superview = superview else { return nil }
        return frame.intersection(superview.bounds)
    }
    
    func expandToTakeCompleteArea(_ parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            self.heightAnchor.constraint(equalTo: parentView.heightAnchor),
            self.widthAnchor.constraint(equalTo: parentView.widthAnchor)
        ])
    }
}
