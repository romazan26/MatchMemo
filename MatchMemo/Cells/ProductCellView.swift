//
//  ProductCellView.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import SwiftUI
import StoreKit

struct ProductCellView: View {
    let product: Product
    var choose = false
    let discripts1 = ["+  Up to 30 profile photos", "+  HD quality", "+  Unlimited events"]
    let discripts2 = ["+  Unlimited profile photos", "+  HD quality", "+  Unlimited events"]
    var body: some View {
        ZStack {
            //MARK: - Discript
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                Color.second
                VStack(alignment: .leading,spacing: 10){
                    if product.id == "oneMonth_pro"{
                        ForEach(discripts1, id: \.self) { discript in
                            Text(discript)
                        }
                    }
                    if product.id == "forever_pro"{
                        ForEach(discripts2, id: \.self) { discript in
                            Text(discript)
                        }
                    }
                }
                .padding()
                .padding(.top, 40)
                .foregroundStyle(.white)
            }
            .frame(width: 356, height: 168)
            .cornerRadius(23)
            .padding(.top, 140)
            
            //MARK: - Price
            ZStack {
                Color.main
                    .overlay {
                        RoundedRectangle(cornerRadius: 27)
                            .stroke(.gray.opacity(0.5), lineWidth: 2.0)
                    }
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(product.displayName)")
                            .foregroundStyle(.gray)
                            .font(.system(size: 11))
                        Text("\(product.displayPrice)$")
                            .foregroundStyle(.white)
                            .font(.system(size: 22,weight: .heavy))
                    }
                    
                    Spacer()
                    if choose{
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundStyle(.bluApp)
                            .frame(width: 29, height: 29)
                    }else{
                        Circle().frame(width: 29).foregroundStyle(.gray)
                    }
                    
                }.padding()
            }
            .frame(width: 356, height: 78)
            .cornerRadius(27)
        }.frame(width: 356, height: 190)
    }
}

//#Preview {
//    ProductCellView()
//}
