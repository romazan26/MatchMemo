//
//  MainView.swift
//  MatchMemo
//
//  Created by Роман on 13.08.2024.
//

import SwiftUI
import PhotosUI

struct MainView: View {
    @EnvironmentObject private var purchaseManager: PurchaseManager
    @State var isPresentSubscire = false
    @State var isPresentUser = false
    
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        return config
    }
    
    var body: some View {
        ZStack {
            //MARK: - Background
            Color.main.ignoresSafeArea()
            //MARK: - MainStack
            VStack {
                if !isPresentSubscire{
                    LoadingView(isPresent: $isPresentSubscire)
                        .task {
                            await self.purchaseManager.updatePurchasedProducts()
                            print(purchaseManager.hasUnlockedPro)
                        }
                        .task {
                            Task {
                                do {
                                    try await purchaseManager.loadProducts()
                                } catch {
                                    print(error)
                                }
                            }
                        }
                }else if !isPresentUser{
                    SubscribeView(simpleProduct: purchaseManager.products.first!, isPresentUser: $isPresentUser)
                }else {
                    UserView()
                }
                    
            }
        }
    }
}

#Preview {
    MainView()
}
