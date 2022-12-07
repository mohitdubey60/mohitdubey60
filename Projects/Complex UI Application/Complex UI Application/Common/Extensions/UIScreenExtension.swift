//
//  UIScreenExtension.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 05/08/22.
//

import UIKit

extension UIScreen {
        // Screen width.
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
        // Screen height.
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}
