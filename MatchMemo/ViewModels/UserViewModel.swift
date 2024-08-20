//
//  UserViewModel.swift
//  MatchMemo
//
//  Created by Роман on 20.08.2024.
//

import Foundation
import UIKit
import CoreData
import PhotosUI

final class UserViewModel: ObservableObject{
    let manager = CoreDataManager.instance
    
    @Published var users: [User] = []
    
    @Published var simpleName = ""
    @Published var simpleExpiriens = ""
    @Published var simplePhoto = UIImage(resource: .user)
    
    @Published var isPresentAddUser = false
    @Published var isPresentEditUser = false
    @Published var isPresentPiker = false
    
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        return config
    }
    
    init(){
        getUsers()
    }
    
    //MARK: - Edite data
    func editUser(){
        let request = NSFetchRequest<User>(entityName: "User")
        
        do{
            users = try manager.context.fetch(request)
            let user = users.first
            user?.name = simpleName
            user?.experience = Int16(simpleExpiriens) ?? 0
            user?.photo = simplePhoto
            
        }catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
        save()
        clear()
        isPresentAddUser.toggle()
    }
    
    //MARK: - Fill data
    func fillUser(){
        simpleName = users.first?.name ?? ""
        simpleExpiriens = String(users.first?.experience ?? 0)
        simplePhoto = users.first?.photo ?? UIImage(resource: .user)
    }
       
    //MARK: - Add User
    func addUser(){
        
        let newUser = User(context: manager.context)
        newUser.name = simpleName
        newUser.experience = Int16(simpleExpiriens) ?? 0
        newUser.photo = simplePhoto
        
        save()
        clear()
        isPresentAddUser.toggle()
        
    }
    
    
    //MARK: - Get data
    func getUsers(){
        let request = NSFetchRequest<User>(entityName: "User")
        
        do{
            users = try manager.context.fetch(request)
        }catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Clear property
    func clear(){
        simpleName = ""
        simpleExpiriens = ""
        simplePhoto = UIImage(resource: .user)
    }
    
    //MARK: - Save data
    func save(){
        users.removeAll()
        manager.save()
        getUsers()
    }
}
