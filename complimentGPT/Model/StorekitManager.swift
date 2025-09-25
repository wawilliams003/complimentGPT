//
//  StorekitManager.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/24/25.
//

import Foundation
import StoreKit

class StorekitManager: NSObject {
  static let shared = StorekitManager()
    override init(){
        super.init()
        startTransactionListener()
    }
    
    var product : Product?
    
    func startTransactionListener() {
        Task {
            for await result in Transaction.updates {
                switch result {
                case .verified(let transaction):
                    await transaction.finish()
                    print("Transaction updated and finished: \(transaction.productID)")
                case .unverified(_, let error):
                    print("Transaction update failed verification: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchProduct() async {
        let productIdentifiers = ["complimentgpt.subscription"]
        do {
            guard let product = try await Product.products(for: productIdentifiers).first else {return}
            self.product = product
            //print("Product fetched: \(product.description)")
        } catch {
            print("failed to fetch products: \(error.localizedDescription)")
        }
    }
    
    func makePayment() async {
        guard let product = self.product else {return}
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    await transaction.finish()
                    print("✅ Purchased: \(transaction.productID)")
                    // Save in UserDefaults
                    
                } else {
                    print("Unverified Transaction")
                }
            case .userCancelled:
                print("User cancelled purchase")
            default:
                break
            }
        } catch {
            print("Purchase failed: \(error.localizedDescription)")
        }
    }
    
    func restorePurchases() async {
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                // ✅ Unlock based on product ID
                if transaction.productID == "complimentgpt.subscription" {
                    //UserDefaults.standard.set(1, forKey: "isPro")
                    print("Restored: \(transaction.productID)")
                    //self.trackPurchaseDelegate?.trackPurchase(isPro: true)
                }
            case .unverified(_, let error):
                print("Restore failed verification: \(error.localizedDescription)")
            }
        }
    }
    
}
