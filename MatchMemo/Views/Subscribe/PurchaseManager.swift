//
//  PurchaseManager.swift
//  MatchMemo
//
//  Created by Роман on 14.08.2024.
//

import Foundation
import StoreKit

@MainActor
class PurchaseManager: ObservableObject {

    private let productIds = ["oneMonth_pro", "forever_pro"]

    @Published
    private(set) var products: [Product] = []
    private var productsLoaded = false

    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
    }

    private var updates: Task<Void, Never>? = nil

        init() {
            updates = observeTransactionUpdates()
        }

        deinit {
            updates?.cancel()
        }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
            Task(priority: .background) { [unowned self] in
                for await verificationResult in Transaction.updates {
                    // Using verificationResult directly would be better
                    // but this way works for this tutorial
                    await self.updatePurchasedProducts()
                }
            }
        }
    
    @Published
       private(set) var purchasedProductIDs = Set<String>()

       var hasUnlockedPro: Bool {
          return !self.purchasedProductIDs.isEmpty
       }

       func updatePurchasedProducts() async {
           for await result in Transaction.currentEntitlements {
               guard case .verified(let transaction) = result else {
                   continue
               }

               if transaction.revocationDate == nil {
                   self.purchasedProductIDs.insert(transaction.productID)
               } else {
                   self.purchasedProductIDs.remove(transaction.productID)
               }
           }
       }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        switch result {
        case let .success(.verified(transaction)):
            await transaction.finish()
            await self.updatePurchasedProducts()
        case let .success(.unverified(_, error)):
            break
        case .pending:
            break
        case .userCancelled:
            break
        @unknown default:
            break
        }
    }
}
