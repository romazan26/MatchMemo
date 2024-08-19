//
//  EventCell.swift
//  MatchMemo
//
//  Created by Роман on 19.08.2024.
//

import SwiftUI

struct EventCell: View {
    let event: Event
    @StateObject var vm: EventsViewmodel
    var body: some View {
        ZStack {
            Color.second
            VStack(alignment: .leading) {
                
                //MARK: - Image and date
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    Image(uiImage: event.photo ?? .addPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 330, height: 186)
                    .cornerRadius(16)
                    Text(Dateformatter(date: event.date ?? Date()))
                        .padding(10)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .heavy))
                        .background(Color.black.cornerRadius(100).opacity(0.7))
                }
                
                //MARK: - Title
                Text(event.title ?? "")
                    .foregroundStyle(.white)
                    .font(.system(size: 16,weight: .heavy))
                
                //MARK: - Discription
                Text(event.discription ?? "")
                    .foregroundStyle(.gray)
                    .font(.system(size: 16))
                Spacer()
                Button(action: {
                    vm.simpleEvent = event
                    vm.isPresentEditEvent.toggle()
                    vm.fillEvent()
                }, label: {
                    BlueButtonView(text: "Open card")
                })
            }.padding()
        }
        .frame(width: 346, height: 358)
        .cornerRadius(22)
    }
    //MARK: - Dateformatter
    private func Dateformatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        return dateFormatter.string(from: date)
    }

}

//#Preview {
//    EventCell()
//}
