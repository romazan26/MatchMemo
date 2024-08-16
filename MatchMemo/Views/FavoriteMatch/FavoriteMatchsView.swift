//
//  FavoriteMatchsView.swift
//  MatchMemo
//
//  Created by Роман on 15.08.2024.
//

import SwiftUI

struct FavoriteMatchsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: MathViewModel
    
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack {
                //MARK: - Top toolBar
                HStack {
                    //MARK: - back button
                    Button(action: {dismiss()}, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 12, height: 15)
                            .foregroundStyle(.white)
                    })
                    Spacer()
                    //MARK: - title view
                    Text("Favorite matches")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .heavy))
                    Spacer()
                    //MARK: - Add photo button
                    Button(action: {vm.isPresentAddMatch.toggle()}, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 39, height: 39)
                    })
                    
                }
                ScrollView {
                    ForEach(vm.matchs) { match in
                        MatchCellView(match: match)
                    }
                    
                }.padding(.top)
                Spacer()
                   
            }
            .sheet(isPresented: $vm.isPresentAddMatch, content: {
                AddNewMatchView(vm: vm)
            })
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    FavoriteMatchsView(vm: MathViewModel())
}
