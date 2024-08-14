//
//  UserView.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import SwiftUI

struct UserView: View {
    @StateObject var photoViewModel = MyPhotosViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - Background
                Color.main.ignoresSafeArea()
                
                //MARK: - Main stack
                VStack {
                    //MARK: - Image user
                    HStack {
                        Spacer()
                        
                        Image(.user)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 112, height: 112)
                            .cornerRadius(50)
                            .padding(.leading, 24)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.gray)
                        })
                    }
                    
                    //MARK: - User name
                    Text("John Rous")
                        .foregroundStyle(.white)
                        .font(.system(size: 23, weight: .heavy))
                    
                    //MARK: - Experience iser
                    Text("3 years of experience")
                        .foregroundStyle(.gray)
                        .font(.system(size: 13))
                        .padding(.bottom)
                    
                    //MARK: - Favorite
                    FavoriteView(image: .favoriteMatch, text: "Favorite matches", count: 0)
                    FavoriteView(image: .favoriteEvents, text: "Favorite events", count: 0)
                    
                    
                    HStack{
                        Text("My photos")
                            .foregroundStyle(.white)
                            .font(.system(size: 19, weight: .heavy))
                        //MARK: - Photos count
                        Text("\(photoViewModel.myPhotos.count)")
                            .foregroundStyle(.gray)
                            .font(.system(size: 19, weight: .heavy))
                        Spacer()
                        
                        //MARK: - See all button
                        NavigationLink {
                            MyPhotoview(vm: photoViewModel)
                        } label: {
                            Image(systemName: "chevron.forward")
                                .foregroundStyle(.gray)
                        }
                    }.padding(10)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(),GridItem(),GridItem()], content: {
                            ForEach(0...5, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: 110, height: 110)
                                    .foregroundStyle(.second)
                            }
                        })
                    }
                    
                    Spacer()
                    
                    //MARK: - Statistics button
                    Button(action: {}, label: {
                        BlueButtonView(text: "Statistics")
                    })
                    
                }.padding()
            }
        }
    }
}

#Preview {
    UserView()
}
