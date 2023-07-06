//
//  LargeTitleFontModifier.swift
//  GuessTheFlag
//
//  Created by Radu Petrisel on 06.07.2023.
//

import SwiftUI

struct LargeBlueTitleFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueTitleFont() -> some View {
        modifier(LargeBlueTitleFontModifier())
    }
}
