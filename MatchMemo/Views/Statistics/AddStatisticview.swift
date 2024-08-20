//
//  AddStatisticview.swift
//  MatchMemo
//
//  Created by Роман on 20.08.2024.
//

import SwiftUI

struct AddStatisticview: View {
    
    var isEdit = false
    @StateObject var vm: StatisticViewModel
    @FocusState private var keyboardIsFocused: Bool
    
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack(spacing: 25) {
                //MARK: - Top toolbar
                HStack {
                    Button(action: {
                        if isEdit {
                            vm.isPresentEditStatistic.toggle()
                        }else{
                            vm.isPresentAddStatistic.toggle()
                        }
                        vm.clear()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 8, height: 14)
                            .foregroundStyle(.white)
                    })
                    Spacer()
                    Text(isEdit ? "Edit Statistic" : "New statistics")
                        .foregroundStyle(.white)
                        .font(.system(size: 23, weight: .heavy))
                    Spacer()
                    
                }
                
                //MARK: - Add date statistic
                DatePicker("Date", selection: $vm.simpleDate, displayedComponents: .date)
                    .colorScheme(.dark)
                    .padding()
                    .background {
                        Color.second
                            .frame(height: 77)
                            .cornerRadius(18)
                    }
                    .padding(.top, 20)
                //MARK: - Add title event
                CustomTextFieldView(placeholder: "Total satary",
                                    height: 77,
                                    text: $vm.simpleSalary)
                .focused($keyboardIsFocused)
                .keyboardType(.numberPad)
                
                Spacer()
                Button(action: {
                    if isEdit{
                        vm.editStatistics()
                    }else{
                        vm.addStatistic()
                    }
                }, label: {
                    BlueButtonView(text: isEdit ? "Edit" : "Save")
                })
            }
        }
    }
}

#Preview {
    AddStatisticview(vm: StatisticViewModel())
}
