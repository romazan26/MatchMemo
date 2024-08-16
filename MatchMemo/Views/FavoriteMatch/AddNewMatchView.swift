//
//  AddNewMatchView.swift
//  MatchMemo
//
//  Created by Роман on 15.08.2024.
//

import SwiftUI

struct AddNewMatchView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var keyboardIsFocused: Bool
    @StateObject var vm: MathViewModel
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            
            VStack(spacing: 20) {
                //MARK: - Top toolbar
                HStack {
                    Button(action: {
                        dismiss()
                        //                        vm.clear()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 8, height: 14)
                            .foregroundStyle(.white)
                    })
                    Spacer()
                    Text("New match")
                        .foregroundStyle(.white)
                        .font(.system(size: 23, weight: .heavy))
                    Spacer()
                    
                }
                //MARK: - Teame 1
                
                HStack{
                    VStack {
                        Text("Team 1")
                            .foregroundStyle(.gray)
                            .font(.system(size: 14))
                        CustomTextFieldView(textAlignment: .center,text: $vm.simpleTitle1)
                            .focused($keyboardIsFocused)
                            .frame(width: 100)
                    }
                    Spacer()
                    
                    Circle()
                        .frame(width: 26)
                        .padding(.horizontal)
                        .foregroundStyle(vm.simpleWin ? .bluApp : .gray)
                }
                
                .onTapGesture {
                    vm.simpleWin = true
                }
                .padding(.vertical, 7)
                .background(content: {
                    Color.second
                        .frame(width: 358, height: 77)
                        .cornerRadius(18)
                })
                .padding(.top, 20)
                
                
                //MARK: - Teame 2
                HStack{
                    VStack {
                        Text("Team 2")
                            .foregroundStyle(.gray)
                            .font(.system(size: 14))
                        CustomTextFieldView(textAlignment: .center,text: $vm.simpleTitle2)
                            .focused($keyboardIsFocused)
                            .frame(width: 100)
                    }
                    Spacer()
                    
                    Circle()
                        .frame(width: 26)
                        .padding(.horizontal)
                        .foregroundStyle(!vm.simpleWin ? .bluApp : .gray)
                }
                .onTapGesture {
                    vm.simpleWin = false
                }
                .padding(.vertical, 7)
                .background(content: {
                    Color.second
                        .frame(width: 358, height: 77)
                        .cornerRadius(18)
                })
                
                
                //MARK: - Match date
                VStack {
                    DatePicker("Date", selection: $vm.simpleDate, displayedComponents: .date)
                        .preferredColorScheme(.dark)
                }
                .padding()
                .background(content: {
                    Color.second
                        .frame(width: 358, height: 77)
                        .cornerRadius(18)
                })
                
                Spacer()
                
                //MARK: - Save button
                Button {
                    vm.isPresentAddMatch = false
                    vm.addMatch()
                } label: {
                    BlueButtonView(text: "Save")
                }
            }
            .padding()
            .onTapGesture {
                keyboardIsFocused = false
            }
        }
    }
}

#Preview {
    AddNewMatchView( vm: MathViewModel())
}
