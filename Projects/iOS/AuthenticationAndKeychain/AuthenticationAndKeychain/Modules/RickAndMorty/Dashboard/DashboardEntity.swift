//
//  DashboardEntity.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 23/03/23.
//

import UIKit

enum BottombarType: CaseIterable {
    case charachter
    case episode
    case location
}
struct DashboardEntity {
    let title: String
    let url: String
    let imageName: String
    let tag: Int
    let type: BottombarType
}
