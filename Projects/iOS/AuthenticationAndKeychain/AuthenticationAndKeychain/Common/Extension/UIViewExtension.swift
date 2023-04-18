//
//  UIViewExtension.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 20/03/23.
//

import UIKit

extension UIView {
    class func fromNib(autoResizeEnabled: Bool = false) -> Self {
        let name = Self.className
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        view.translatesAutoresizingMaskIntoConstraints = autoResizeEnabled
        return view
    }
}
