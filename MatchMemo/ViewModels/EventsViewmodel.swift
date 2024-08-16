//
//  EventsViewmodel.swift
//  MatchMemo
//
//  Created by Роман on 16.08.2024.
//

import Foundation
import CoreData
import UIKit

final class EventsViewmodel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var events: [Event] = []
    
    @Published var simplePhoto: UIImage = UIImage(resource: .event)
    @Published var simpleDiscription = ""
    @Published var simpleDate = Date()
    
    @Published var isPresentAddEvent = false
    
    init(){
        getEvents()
    }
    
    
//    //MARK: - Get hwo is winner
//    func getWin(a: Int16, b: Int16) -> Bool{
//        if a > b {
//            return true
//        }else {
//            return false
//        }
//    }
//    
//    //MARK: - Add Match
//    func addMatch(){
//        var a = Int16.random(in: 1...10)
//        var b = Int16.random(in: 1...10)
//        let newMatch = Match(context: manager.context)
//        newMatch.teamTitle1 = simpleTitle1
//        newMatch.teamTitle2 = simpleTitle2
//        newMatch.score1 = a
//        newMatch.score2 = b
//        newMatch.winner = getWin(a: newMatch.score1, b: newMatch.score2)
//        
//        save()
//        clear()
//    }
//    
//    
    //MARK: - Get data
    func getEvents(){
        let request = NSFetchRequest<Event>(entityName: "Event")
        
        do{
            events = try manager.context.fetch(request)
        }catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
//    //MARK: - Clear property
//    func clear(){
//        simpleTitle1 = ""
//        simpleTitle2 = ""
//    }
//    
//    //MARK: - Save data
//    func save(){
//        matchs.removeAll()
//        manager.save()
//        getMatch()
//    }
}
