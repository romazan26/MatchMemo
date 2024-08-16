//
//  MatchCellView.swift
//  MatchMemo
//
//  Created by Роман on 15.08.2024.
//

import SwiftUI

struct MatchCellView: View {
    let match: Match
    var body: some View {
        ZStack {
            Color.second
            HStack(alignment: .top) {
                Spacer()
                VStack {
                    Text("\(match.score1):\(match.score2)")
                        .foregroundStyle(.white)
                        .font(.system(size: 58, weight: .heavy))
                    HStack {
                        Text("\(match.teamTitle1 ?? "") -").foregroundStyle(match.winner ? .bluApp : .white)
                        Text("\(match.teamTitle2 ?? "")").foregroundStyle(match.winner ? .white : .bluApp)
                    }.font(.system(size: 18, weight: .heavy))
                }.padding(.leading, 70)
                Spacer()
                Text(Dateformatter(date: match.date ?? Date()))
                    .foregroundStyle(.white)
                    .font(.system(size: 13))
                    .padding(6)
                    .background(Color.gray.cornerRadius(83))
            }.padding()
        }
        .frame(height: 116)
        .cornerRadius(16)
    }
    
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }

}

//#Preview {
//    MatchCellView()
//}
