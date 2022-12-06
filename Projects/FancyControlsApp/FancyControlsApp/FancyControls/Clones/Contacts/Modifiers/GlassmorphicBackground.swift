//
//  GlassmorphicBackground.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 06/12/22.
//

import SwiftUI

struct GlassmorphicBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
