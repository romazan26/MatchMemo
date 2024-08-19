//
//  StatisticCell.swift
//  MatchMemo
//
//  Created by Роман on 19.08.2024.
//

import SwiftUI

struct StatisticCellView: View {
    @StateObject var vm: StatisticViewModel
    let statistic: Statistic
    var body: some View {
        ZStack {
            Color.second
            VStack {
                HStack {
                    //MARK: - Date statistic
                    Text(Dateformatter(date: Date()))
                        .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .heavy))
                    
                    Spacer()
                    
                    //MARK: - Edit button
                    Button(action: {}, label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(.gray)
                    })
                }
                Spacer()
                HStack{
                    //MARK: - Salary
                    Text("2 570$")
                        .foregroundStyle(.white)
                        .font(.system(size: 40, weight: .heavy))
                    
                    Spacer()
                    
                    //MARK: - difference in salary
                    Image(systemName: "arrow.down")
                        .foregroundStyle(.gray)
                    Text("300$")
                        .foregroundStyle(.gray)
                        .font(.system(size: 30, weight: .bold))
                }
            }
            .padding()
        }.frame(width: 358, height: 124)
            .cornerRadius(18)
    }
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    StatisticCellView(vm: StatisticViewModel(), statistic: Statistic())
}
