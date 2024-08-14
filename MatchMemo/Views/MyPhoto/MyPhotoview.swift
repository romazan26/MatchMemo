//
//  MyPhotoview.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import SwiftUI

struct MyPhotoview: View {
    @StateObject var vm: MyPhotosViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            //MARK: - Background
            Color.main.ignoresSafeArea()
            
            //MARK: - Main Stack
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
                    Text("My photos")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .heavy))
                    Spacer()
                    //MARK: - Add photo button
                    Button(action: {vm.isPresentPiker.toggle()}, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 39, height: 39)
                    })
                    .disabled(vm.isEditMode ? true : false)
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(),GridItem(),GridItem()], content: {
                        ForEach(vm.myPhotos) { photo in
                            if vm.isEditMode {
                                ZStack{
                                    Image(uiImage: photo.photo ?? UIImage(resource: .simple))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 110, height: 110)
                                        .cornerRadius(6)
                                        .opacity(0.5)
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 39, height: 39)
                                        .foregroundStyle(.gray)
                                        .onTapGesture {
                                            vm.deletePhoto(photo: photo)
                                        }
                                }
                            }else{
                                Image(uiImage: photo.photo ?? UIImage(resource: .simple))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 110)
                                    .cornerRadius(6)
                            }
                        }
                    })
                }
                Spacer()
                //MARK: - Edit button
                Button(action: {vm.isEditMode.toggle()}, label: {
                    BlueButtonView(text: vm.isEditMode ? "Save": "Edit")
                })
            }.padding()
                .navigationBarBackButtonHidden()
        }
        .sheet(isPresented: $vm.isPresentPiker, content: {
            PhotoPicker(configuration: vm.config, image: $vm.simplePhoto, isPresented: $vm.isPresentPiker)
                .onDisappear(perform: {
                    vm.addFoto()
                })
        })
    }
}

#Preview {
    NavigationView {
        MyPhotoview(vm: MyPhotosViewModel())
    }
}
