//
//  LoadingView.swift
//  MatchMemo
//
//  Created by Роман on 13.08.2024.
//

import SwiftUI

struct LoadingView: View {
    @State private var percents: Float = 0
    @Binding var isPresent: Bool
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 220, height: 110)
                    .padding(.top, 150)
                
                Spacer()
                ProgressCircleView(progress: percents / 100)
                    .frame(width: 100, height: 100)
                    .padding()
            }
        }.onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                if percents < 100{
                    percents += 1
                }else {
                    timer.invalidate()
                    isPresent = true
                }
            }
        })
        .fullScreenCover(isPresented: $isPresent, content: {
            MainView()
        })
    }
}

#Preview {
    LoadingView(isPresent: .constant(false))
}
