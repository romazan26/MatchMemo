//
//  addEventView.swift
//  MatchMemo
//
//  Created by Роман on 19.08.2024.
//

import SwiftUI

struct AddEventView: View {
    
    var isEdit = false
    
    @FocusState private var keyboardIsFocused: Bool
    @StateObject var vm: EventsViewmodel

    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack(spacing: 10) {
                //MARK: - Top toolbar
                HStack {
                    Button(action: {
                        if isEdit {
                            vm.isPresentEditEvent.toggle()
                        }else{
                            vm.isPresentAddEvent.toggle()
                        }
                        vm.clear()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 8, height: 14)
                            .foregroundStyle(.white)
                    })
                    Spacer()
                    Text(isEdit ? vm.simpleTitle : "New event")
                        .foregroundStyle(.white)
                        .font(.system(size: 23, weight: .heavy))
                    Spacer()
                    
                }
                
                //MARK: - Add Image event
                Button(action: {vm.isPresentPiker.toggle()}, label: {
                    Image(uiImage: vm.simplePhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 358, height: 201)
                        .cornerRadius(16)
                })
                .padding(.top, 20)
                
                //MARK: - Add title event
                CustomTextFieldView(placeholder: "Event title", 
                                    height: 77,
                                    text: $vm.simpleTitle)
                .focused($keyboardIsFocused)
                
                //MARK: - Add date event
                DatePicker("Date event", selection: $vm.simpleDate, displayedComponents: .date)
                    .colorScheme(.dark)
                    .padding()
                    .background {
                        Color.second.cornerRadius(18)
                    }
                
                //MARK: - Discription
                ZStack {
                    Color.second
                        
                    MultiLineTF(txt: $vm.simpleDiscription,
                                placehold: vm.simpleDiscription.isEmpty ? "Discription" : vm.simpleDiscription)
                        .padding()
                        .focused($keyboardIsFocused)
                    
                    Text("\(vm.simpleDiscription.count)/1500")
                        .foregroundStyle(.gray)
                        .offset(x: 140, y: 70)
                }
                .frame(width: 358, height: 183)
                .cornerRadius(18)
                    
                       
                    
                Spacer()
                
                //MARK: - Save button
                Button(action: {
                    if isEdit {
                        vm.editEvevnt()
                    }else {
                        vm.addEvent()
                    }
                   
                }, label: {
                    BlueButtonView(text: isEdit ? "Edit" : "Save")
                })
            }
            .onAppear(perform: {
                if isEdit{
                    vm.fillEvent()
                }
            })
            .sheet(isPresented: $vm.isPresentPiker, content: {
                PhotoPicker(configuration: vm.config, image: $vm.simplePhoto, isPresented: $vm.isPresentPiker)
            })
            .padding()
        }
    }
}

#Preview {
    AddEventView(vm: EventsViewmodel())
}
