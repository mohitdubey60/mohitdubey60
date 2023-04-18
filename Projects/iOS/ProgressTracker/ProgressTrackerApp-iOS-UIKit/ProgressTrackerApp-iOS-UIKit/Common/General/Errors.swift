//
//  Errors.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 14/02/23.
//

import Foundation

//MARK: Collection control errors
enum CollectionControlErrors: Error {
    case noMatchingCellToDequeue
}

extension CollectionControlErrors: CustomStringConvertible {
    public var description: String {
        switch self {
            case .noMatchingCellToDequeue:
                return "Did not register any matching cell for this error"
        }
    }
}

extension CollectionControlErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .noMatchingCellToDequeue:
                return "Did not register any matching cell for this error"
        }
    }
}
