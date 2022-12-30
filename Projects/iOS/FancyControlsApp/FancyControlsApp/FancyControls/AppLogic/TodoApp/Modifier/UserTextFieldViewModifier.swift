//
//  UserTextFieldViewModifier.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 10/12/22.
//

import SwiftUI

struct UserTextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(10)
    }
}
