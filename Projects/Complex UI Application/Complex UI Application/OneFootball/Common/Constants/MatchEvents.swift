//
//  MatchEvents.swift
//  Complex UI Application
//
//  Created by mohit.dubey on 25/09/22.
//

import UIKit

enum PlayerCard: String {
    case red = "RED"
    case yellow = "YELLOW"
    
    var color: UIColor {
        switch self {
            case .red:
                return .red
            case .yellow:
                return .yellow
        }
    }
}

enum PlayerRating: String {
    case high = "HIGH"
    case medium = "MEDIUM"
    case low = "LOW"
    
    var color: UIColor {
        switch self {
            case .high:
                return .green
            case .medium:
                return .yellow
            case .low:
                return .yellow
        }
    }
}
