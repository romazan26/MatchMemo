//
//  StatisticCell.swift
//  MatchMemo
//
//  Created by Роман on 19.08.2024.
//

import SwiftUI

struct StatisticCellView: View {
    
    @StateObject var vm: StatisticViewModel
    
    @ObservedObject var statistic: Statistic
    var beforeSalary: Int16
    
    @State private var different: Int16 = 0
    @State private var upOrDown = false
    
    var body: some View {
        ZStack {
            Color.second
            VStack {
                HStack {
                    //MARK: - Date statistic
                    Text(Dateformatter(date: statistic.date ?? Date()))
                        .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .heavy))
                    
                    Spacer()
                    
                    //MARK: - Edit button
                    Button(action: {
                        vm.isPresentEditStatistic.toggle()
                        vm.simpleStatic = statistic
                        vm.fillStatistic()
                    }, label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(.gray)
                    })
                }
                Spacer()
                HStack{
                    //MARK: - Salary
                    Text("\(statistic.salary)$")
                        .foregroundStyle(.white)
                        .font(.system(size: 40, weight: .heavy))
                    
                    Spacer()
                    
                    //MARK: - difference in salary
                    Image(systemName: upOrDown ? "arrow.up" : "arrow.down")
                        .foregroundStyle(.gray)
                    Text("\(different)$")
                        .foregroundStyle(.gray)
                        .font(.system(size: 30, weight: .bold))
                }
            }
            .padding()
        }
        .onAppear(perform: {
            getDifferent()
        })
        .frame(width: 358, height: 124)
            .cornerRadius(18)
    }
    
    //MARK: - Get different salary
    private func getDifferent(){
        if beforeSalary > statistic.salary{
            different = beforeSalary - statistic.salary
            upOrDown = false
        }else{
            different = statistic.salary - different
            upOrDown = true
        }
    }
    
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    StatisticCellView(vm: StatisticViewModel(), statistic: Statistic(), beforeSalary: 100)
}
