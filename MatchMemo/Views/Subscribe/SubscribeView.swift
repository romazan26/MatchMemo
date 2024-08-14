//
//  SubscribeView.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import SwiftUI
import StoreKit

struct SubscribeView: View {
    @EnvironmentObject private var purchaseManager: PurchaseManager
    @State var simpleProduct: Product
    @Binding var isPresentUser: Bool
        

        var body: some View {
            VStack(spacing: 20) {
                //MARK: - Title
                HStack{
                    Spacer()
                    Text("SUBSCRIBE")
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .heavy))
                        .padding(10)
                        .background(Color.bluApp.cornerRadius(88))
                    Spacer()
                    Button(action: {isPresentUser.toggle()}, label: {
                        Image(systemName: "xmark").foregroundStyle(.gray)
                    })
                }
                Text("More possibilities").foregroundStyle(.white)
                    .font(.system(size: 24, weight: .heavy))
                
                //MARK: - Product list
                if purchaseManager.hasUnlockedPro {
                    Spacer()
                    Text("Thank you for purchasing subscribe!").foregroundStyle(.white)
                    Spacer()
                    Button(action: {isPresentUser.toggle()}, label: {
                        BlueButtonView(text: "Let's go")
                    })
                } else {
                    ForEach(purchaseManager.products) { product in
                        ProductCellView(product: product, choose: simpleProduct.id == product.id ? true : false)
                            .onTapGesture {
                                simpleProduct = product
                            }
                    }
                    Spacer()
                    Divider()
                    //MARK: - Price
                    HStack{
                        Text("To pay:")
                            .foregroundStyle(.white)
                            .font(.system(size: 17, weight: .heavy))
                        Spacer()
                        Text("\(simpleProduct.displayPrice)$")
                            .foregroundStyle(.white)
                            .font(.system(size: 22, weight: .heavy))
                    }
                    
                    //MARK: - Pay button
                    Button {
                        Task {
                            do {
                                try await purchaseManager.purchase(simpleProduct)
                            } catch {
                                print(error)
                            }
                            await self.purchaseManager.updatePurchasedProducts()
                        }
                    } label: {
                        BlueButtonView(text: "Pay now")
                    }
                }
                
            }.padding()
        }
}

//#Preview {
//    SubscribeView(simpleProduct: Product)
//}
