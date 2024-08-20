//
//  UserView.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject private var purchaseManager: PurchaseManager
    
    @StateObject var matchViewModel = MathViewModel()
    @StateObject var photoViewModel = MyPhotosViewModel()
    @StateObject var eventsViewModel = EventsViewmodel()
    @StateObject var statisticViewModel = StatisticViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - Background
                Color.main.ignoresSafeArea()
                
                //MARK: - Main stack
                VStack {
                    Group{
                        //MARK: - Image user
                        
                        HStack {
                            Spacer()
                            
                            Image(uiImage: userViewModel.users.first?.photo ?? UIImage(resource: .user))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 112, height: 112)
                                .cornerRadius(50)
                                .padding(.leading, 24)
                            
                            Spacer()
                            //MARK: - Settings button
                            NavigationLink {
                                SettingsView()
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.gray)
                            }
                        }
                        
                        //MARK: - User name
                        HStack {
                            Text(userViewModel.users.first?.name ?? "enter name")
                                .foregroundStyle(.white)
                                .font(.system(size: 23, weight: .heavy))
                            
                            //MARK: - Edit user name button
                            Button(action: {
                                    userViewModel.isPresentAddUser.toggle()
                            }, label: {
                                Image(systemName: userViewModel.users.isEmpty ? "plus" : "pencil")
                                    .foregroundStyle(.gray)
                            })
                            
                        }
                    }
                    
                    //MARK: - Experience user
                    Text("\(userViewModel.users.first?.experience ?? 0) years of experience")
                        .foregroundStyle(.gray)
                        .font(.system(size: 13))
                        .padding(.bottom)
                    
                    //MARK: - Favorite matchs
                    NavigationLink {
                        FavoriteMatchsView(vm: matchViewModel)
                    } label: {
                        FavoriteView(image: .favoriteMatch, text: "Favorite matches", count: matchViewModel.matchs.count)
                    }
                    //MARK: - Favorite evens
                    NavigationLink {
                        FavoriteEventsView(vm: eventsViewModel)
                    } label: {
                        FavoriteView(image: .favoriteEvents, text: "Favorite events", count: eventsViewModel.events.count)
                    }

                    //MARK: - Photos count
                    HStack{
                        Text("My photos")
                            .foregroundStyle(.white)
                            .font(.system(size: 19, weight: .heavy))
                        
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
                    
                    //MARK: - MyPhotos list
                    ScrollView {
                        ZStack {
                            LazyVGrid(columns: [GridItem(),GridItem(),GridItem()], content: {
                                if purchaseManager.hasUnlockedPro {
                                    ForEach(photoViewModel.myPhotos.prefix(5)) { photo in
                                        Image(uiImage: photo.photo ?? UIImage(resource: .simple))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 110, height: 110)
                                            .cornerRadius(6)
                                    }
                                }else{
                                    
                                        ForEach(0...5, id: \.self) { index in
                                            RoundedRectangle(cornerRadius: 6)
                                                .frame(width: 110, height: 110)
                                                .foregroundStyle(.second)
                                        }
                                       
                                    
                                }
                            })
                            if !purchaseManager.hasUnlockedPro{
                                VStack{
                                    Text("from 4.90$").foregroundStyle(.white).font(.title)
                                    Button(action: {photoViewModel.isPresentMain.toggle()}, label: {
                                        BlueButtonView(text: "Subscribe")
                                    }).frame(width: 173)
                                    
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    //MARK: - Statistics button
                    NavigationLink {
                        StatisticView(vm: statisticViewModel)
                    } label: {
                        BlueButtonView(text: "Statistics")
                    }
                    
                }.padding()
                if userViewModel.isPresentAddUser {
                    AddUser(vm: userViewModel)
                }
            }
        }
        .fullScreenCover(isPresented: $photoViewModel.isPresentMain, content: {
            MainView()
        })
    }
}

//#Preview {
//    NavigationView {
//        UserView()
//    }
//}
