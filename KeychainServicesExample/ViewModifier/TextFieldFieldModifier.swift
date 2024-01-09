//
//  TextFieldFieldModifier.swift
//  KeychainServicesExample
//
//  Created by kanagasabapathy on 09/01/24.
//

import SwiftUI

struct TextFieldFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal)
    }
}

struct TextValueModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .font(.title)
            .bold()
    }
}

extension View {
    func customTextField() -> some View {
        modifier(TextFieldFieldModifier())
    }
    func customTextValue() -> some View {
        modifier(TextValueModifier())
    }
}
