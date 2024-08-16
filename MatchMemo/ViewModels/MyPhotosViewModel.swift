//
//  MyPhotosViewModel.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import Foundation
import CoreData
import UIKit
import PhotosUI

final class MyPhotosViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var myPhotos:[MyPhoto] = []
    @Published var simplePhoto: UIImage = UIImage(resource: .simple)
    @Published var isPresentPiker = false
    @Published var isEditMode = false
    @Published var isPresentMain = false
    
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        return config
    }
    
    init(){
        getMyhotos()
    }
    
    
    //MARK: - Delete data
    func deletePhoto(photo: MyPhoto){
        manager.context.delete(photo)
        save()
    }
    
    //MARK: - add Data
    func addFoto(){
        let newPhoto = MyPhoto(context: manager.context)
        newPhoto.photo = simplePhoto
        save()
    }
    
    //MARK: - Get data
    func getMyhotos(){
        let request = NSFetchRequest<MyPhoto>(entityName: "MyPhoto")
        do {
            myPhotos = try manager.context.fetch(request)
        }catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Save data
    func save(){
        myPhotos.removeAll()
        manager.save()
        getMyhotos()
    }
}
