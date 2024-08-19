//
//  CustomTextFieldView.swift
//  FastTrack
//
//  Created by Роман on 24.07.2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    var placeholder = ""
    var alignment: Alignment = .leading
    var textAlignment: TextAlignment = .leading
    var height: CGFloat = 34
    @Binding var text: String
    var body: some View {
        ZStack(alignment: alignment) {
            Color.second
            if text.isEmpty {
                Text(placeholder)
                    .padding(.horizontal)
                    .foregroundStyle(.white.opacity(0.4))
                    .font(.system(size: 15))
            }
            TextField("", text: $text)
                .padding(.horizontal)
                .foregroundStyle(.white)
                .multilineTextAlignment(textAlignment)
                .font(.system(size: 20,weight: .heavy))
        }
        .cornerRadius(25)
        .frame(maxWidth: .infinity)
        .frame(height: height)
    }
}

#Preview {
    CustomTextFieldView( text: .constant("dfd"))
}
