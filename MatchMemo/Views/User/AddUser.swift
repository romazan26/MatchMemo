//
//  AddUser.swift
//  MatchMemo
//
//  Created by Роман on 20.08.2024.
//

import SwiftUI

struct AddUser: View {
    @StateObject var vm: UserViewModel
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea().opacity(0.8)
            VStack{
                //MARK: - Image user

                Button(action: {vm.isPresentPiker.toggle()}, label: {
                    Image(uiImage: vm.simplePhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 112, height: 112)
                        .cornerRadius(100)
                })
                    

                //MARK: - User name
                CustomTextFieldView(placeholder: "Enter user name", height: 77, text: $vm.simpleName)
                
                //MARK: - Experience user
                CustomTextFieldView(placeholder: "Enter years of experience", height: 77, text: $vm.simpleExpiriens)
                
                //MARK: - Save button
                Button(action: {
                    if vm.users.isEmpty{
                        vm.addUser()
                    }else{
                        vm.editUser()
                    }
                }, label: {
                    BlueButtonView(text: "Save")
                })
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $vm.isPresentPiker, content: {
                PhotoPicker(configuration: vm.config, image: $vm.simplePhoto, isPresented: $vm.isPresentPiker)
            })
            .frame(width: 250)
        }
        .onAppear(perform: {
            if !vm.users.isEmpty{
                vm.fillUser()
            }
        })
    }
}

#Preview {
    AddUser(vm: UserViewModel())
}
