//
//  FavoriteEventsView.swift
//  MatchMemo
//
//  Created by Роман on 16.08.2024.
//

import SwiftUI

struct FavoriteEventsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: EventsViewmodel
    var body: some View {
        ZStack {
            //MARK: - Background
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
                    Text("Favorite events")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .heavy))
                        .offset(x: 15)
                    Spacer()
                    //MARK: - Add photo button
                    Button(action: {
                        vm.isPresentAddEvent.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 39, height: 39)
                    })
                    
                }
                
                ScrollView {
                    ForEach(vm.events) { event in
                        EventCell(event: event, vm: vm)
                    }
                }
                Spacer()
            }.padding()
                .navigationBarBackButtonHidden()
        }
        .sheet(isPresented: $vm.isPresentEditEvent, content: {
            AddEventView(isEdit: true, vm: vm)
        })
        .sheet(isPresented: $vm.isPresentAddEvent, content: {
            AddEventView(vm: vm)
        })
    }
}

#Preview {
    FavoriteEventsView(vm: EventsViewmodel())
}
