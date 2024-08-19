//
//  EventsViewmodel.swift
//  MatchMemo
//
//  Created by Роман on 16.08.2024.
//

import Foundation
import CoreData
import UIKit
import PhotosUI

final class EventsViewmodel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var events: [Event] = []
    @Published var simpleEvent: Event!
    
    @Published var simplePhoto: UIImage = UIImage(resource: .addPhoto)
    @Published var simpleDiscription = ""
    @Published var simpleDate = Date()
    @Published var simpleTitle = ""
    
    @Published var isPresentAddEvent = false
    @Published var isPresentEditEvent = false
    @Published var isPresentPiker = false
    
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        return config
    }
    
    init(){
        getEvents()
    }
    
    //MARK: - Edite data
    func editEvevnt(){
        let request = NSFetchRequest<Event>(entityName: "Event")
        
        do{
            events = try manager.context.fetch(request)
            let event = events.first(where: {$0.id == simpleEvent.id})
            event?.date = simpleDate
            event?.discription = simpleDiscription
            event?.photo = simplePhoto
            event?.title = simpleTitle
        }catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
        save()
        clear()
        isPresentEditEvent.toggle()
    }
    
    //MARK: - Fill data
    func fillEvent(){
        simpleDate = simpleEvent.date ?? Date()
        simpleDiscription = simpleEvent.discription ?? ""
        simpleTitle = simpleEvent.title ?? ""
        simplePhoto = simpleEvent.photo ?? UIImage(resource: .addPhoto)
    }
       
    //MARK: - Add Event
    func addEvent(){
        
        let newEvent = Event(context: manager.context)
        newEvent.date = simpleDate
        newEvent.discription = simpleDiscription
        newEvent.photo = simplePhoto
        newEvent.title = simpleTitle
        
        save()
        clear()
        isPresentAddEvent.toggle()
    }
    
    
    //MARK: - Get data
    func getEvents(){
        let request = NSFetchRequest<Event>(entityName: "Event")
        
        do{
            events = try manager.context.fetch(request)
        }catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Clear property
    func clear(){
        simplePhoto = UIImage(resource: .addPhoto)
        simpleDiscription = ""
        simpleTitle = ""
    }
    
    //MARK: - Save data
    func save(){
        events.removeAll()
        manager.save()
        getEvents()
    }
}
