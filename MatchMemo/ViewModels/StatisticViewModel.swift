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
    @Published var simpleStatic: Statistic!
    
    @Published var simpleDate = Date()
    @Published var simpleSalary = ""
    @Published var simpleDifferent = 0
    
    @Published var isPresentAddStatistic = false
    @Published var isPresentEditStatistic = false
    
    init(){
        getStatistic()
    }
    
    //MARK: - Edite data
    func editStatistics(){
        let request = NSFetchRequest<Statistic>(entityName: "Statistic")
        
        do{
            statistics = try manager.context.fetch(request)
            let statistic = statistics.first(where: {$0.id == simpleStatic.id})
            statistic?.date = simpleDate
            statistic?.salary = Int16(simpleSalary) ?? 0
            
        }catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
        save()
        clear()
        isPresentEditStatistic.toggle()
    }
    
    //MARK: - Fill data
    func fillStatistic(){
        simpleDate = simpleStatic.date ?? Date()
        simpleSalary = String(simpleStatic.salary)
    }
       
    //MARK: - Add Statistc
    func addStatistic(){
        
        let newStatistic = Statistic(context: manager.context)
        newStatistic.date = simpleDate
        newStatistic.salary = Int16(simpleSalary) ?? 0
        
        
        save()
        clear()
        isPresentAddStatistic.toggle()
        
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
