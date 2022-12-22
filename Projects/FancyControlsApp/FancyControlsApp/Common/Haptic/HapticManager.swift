//
//  HapticManager.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 20/12/22.
//

import Foundation
import SwiftUI

class HapticManager {
    static let shared: HapticManager = HapticManager()
    private init() {}
    
    func notification(type feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(feedbackType)
    }
    
    func impact(type feedbackType: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: feedbackType)
        generator.impactOccurred()
    }
}
