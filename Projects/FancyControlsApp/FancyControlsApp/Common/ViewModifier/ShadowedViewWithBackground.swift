//
//  ShadowedViewWithBackground.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 30/11/22.
//

import SwiftUI

struct ShadowedCTAViewWithBackground: ViewModifier {
    var background = Color.accentColor
    func body(content: Content) -> some View {
        content
            .padding(8)
            .padding(.horizontal)
            .background(background)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}
