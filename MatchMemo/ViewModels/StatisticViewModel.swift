//
//  StatisticViewModel.swift
//  MatchMemo
//
//  Created by Роман on 19.08.2024.
//

import Foundation
import CoreData

final class StatisticViewModel: ObservableObject{
    let manager = CoreDataManager.instance
    
    @Published var statistics: [Statistic] = []
    
    @Published var simpleDate = Date()
    @Published var simpleSalary = ""
    @Published var simpleDifferent = 0
    
    init(){
        getStatistic()
    }
    
//    //MARK: - Edite data
//    func editEvevnt(){
//        let request = NSFetchRequest<Event>(entityName: "Event")
//        
//        do{
//            events = try manager.context.fetch(request)
//            let event = events.first(where: {$0.id == simpleEvent.id})
//            event?.date = simpleDate
//            event?.discription = simpleDiscription
//            event?.photo = simplePhoto
//            event?.title = simpleTitle
//        }catch let error{
//            print("Error fetching: \(error.localizedDescription)")
//        }
//        save()
//        clear()
//        isPresentEditEvent.toggle()
//    }
//    
//    //MARK: - Fill data
//    func fillEvent(){
//        simpleDate = simpleEvent.date ?? Date()
//        simpleDiscription = simpleEvent.discription ?? ""
//        simpleTitle = simpleEvent.title ?? ""
//        simplePhoto = simpleEvent.photo ?? UIImage(resource: .addPhoto)
//    }
//       
    //MARK: - Add Event
    func addEvent(){
        
        let newStatistic = Statistic(context: manager.context)
        newStatistic.date = simpleDate
        newStatistic.salary = Int16(simpleSalary) ?? 0
        
        
        save()
        clear()
        
    }
    
    
    //MARK: - Get data
    func getStatistic(){
        let request = NSFetchRequest<Statistic>(entityName: "Statistic")
        
        do{
            statistics = try manager.context.fetch(request)
        }catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Clear property
    func clear(){
        simpleDate = Date()
        simpleSalary = ""
    }
    
    //MARK: - Save data
    func save(){
        statistics.removeAll()
        manager.save()
        getStatistic()
    }
    
}
