//
//  StatisticView.swift
//  MatchMemo
//
//  Created by Роман on 19.08.2024.
//

import SwiftUI

struct StatisticView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: StatisticViewModel
    var body: some View {
        ZStack {
            //MARK: - Background
            Color.main.ignoresSafeArea()
            VStack {
                //MARK: - Top toolBar
                HStack {
                    //MARK: - back button
                    Button(action: {dismiss()}, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 12, height: 15)
                            .foregroundStyle(.white)
                    })
                    Spacer()
                    //MARK: - title view
                    Text("Statistics")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .heavy))
                        .offset(x: 15)
                    Spacer()
                    //MARK: - Add photo button
                    Button(action: {
                        // vm.isPresentAddEvent.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 39, height: 39)
                    })
                    
                }
                ScrollView {
                    ForEach(vm.statistics) { statistic in
                        StatisticCellView(vm: vm, statistic: statistic)
                    }
                }
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    StatisticView(vm: StatisticViewModel())
}

extension BidirectionalCollection where Iterator.Element: Equatable {
    typealias Element = Self.Iterator.Element

    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let lastItem: Bool = (index(after:itemIndex) == endIndex)
            if loop && lastItem {
                return self.first
            } else if lastItem {
                return nil
            } else {
                return self[index(after:itemIndex)]
            }
        }
        return nil
    }

    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop && firstItem {
                return self.last
            } else if firstItem {
                return nil
            } else {
                return self[index(before:itemIndex)]
            }
        }
        return nil
    }
}
