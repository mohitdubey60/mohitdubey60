//
//  RootCoordinator.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 29/12/22.
//

import Foundation
import SwiftUI

final class RootCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var page = AllPages.home
    @Published var sheet: AllSheets?
    
    var isBackEnabled: Bool {
        path.count > 0
    }
    
    let items: [String] = ["iPhone 14", "iPhone 14 Pro", "iPhone 14 Pro Max"]
    
    //Destroy all and move to home
    func gotoHome() {
        path.append(AllPages.home)
    }
    func eraseToHome() {
        path.removeLast(path.count)
    }
    func gotoList() {
        path.append(AllPages.list)
    }
    func gotoDetail(_ product: String) {
        path.append(AllPages.detail(product))
    }
    func openSheet() {
        sheet = .popup
    }
    
    func goBack() {
        if isBackEnabled {
            path.removeLast()
        }
    }
    
    @ViewBuilder
    func getPage(_ page: AllPages) -> some View {
        switch page {
            case .home:
                CoordinatorHomeView()
            case .list:
                CoordinatorListView()
            case .detail(let product):
                CoordinatorDetailView(product: product)
        }
    }
    
    @ViewBuilder
    func getSheet(_ sheet: AllSheets) -> some View {
        switch sheet {
            case .popup:
                PopupView()
        }
    }
}

enum AllPages: Hashable {
    case home, list
    case detail(String)
    
    func hash(into hasher: inout Hasher) {
        switch self {
            case .home:
                hasher.combine(1)
            case .list:
                hasher.combine(2)
            case .detail(let product):
                hasher.combine(product)
        }
    }
//    var id: String {self.rawValue}
}

enum AllSheets: String, CaseIterable, Identifiable {
    case popup
    
    var id: String {self.rawValue}
}
