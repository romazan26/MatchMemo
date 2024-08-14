//
//  FavoriteView.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import SwiftUI

struct FavoriteView: View {
var image: ImageResource
    var text: String
    var count: Int
    var body: some View {
        ZStack{
            Color.main
                .cornerRadius(6)
                .overlay {
                    RoundedRectangle(cornerRadius: 27)
                        .stroke(.gray.opacity(0.5), lineWidth: 2.0)
                }
            HStack{
                //MARK: - Image
                ZStack{
                    Circle()
                        .foregroundColor(.second)
                        .frame(width: 55)
                    Image(image)
                        .resizable()
                        .frame(width: 19, height: 19)
                }
                Spacer()
                //MARK: - Text
                Text(text)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .heavy))
                Spacer()
                //MARK: - Count
                ZStack{
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundStyle(.bluApp)
                        .frame(width: 55, height: 29)
                    Text("\(count)")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .heavy))
                }
            }.padding()
        }
        .frame(width: .infinity, height: 78)
        .cornerRadius(27)
    }
}

#Preview {
    FavoriteView(image: .favoriteMatch, text: "Favorite matches", count: 0)
}
