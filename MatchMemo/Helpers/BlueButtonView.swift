//
//  BlueButtonView.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import SwiftUI

struct BlueButtonView: View {
    var text = "Pay"
    var body: some View {
        ZStack {
            Color.bluApp
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .heavy))
        }
        .frame(height: 69)
        .frame(width: .infinity)
        .cornerRadius(50)
    }
}

#Preview {
    BlueButtonView()
}
