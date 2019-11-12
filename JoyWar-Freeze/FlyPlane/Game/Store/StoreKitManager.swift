//
//  StoreKitManager.swift
//  Game
//
//  Created by Daniel Slupskiy on 20.08.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

typealias CompletionHandler = (_ success: Bool) -> ()

import Foundation
import StoreKit
import SwiftSpinner
import SpriteKit

protocol RemoveAdsDelegate {
    func removeAds() -> Void
}

class StoreKitManager: NSObject {
    
    
    // MARK: Singleton
    
    static let shared = StoreKitManager()
    
    var delegate: RemoveAdsDelegate!
    
    private override init(){
        super.init()
        SKPaymentQueue.default().add(self)
    }
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    
    // MARK: Properties
    var removeAdsNode: SKSpriteNode!
    
    var productsRequest: SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete: CompletionHandler?
    
    
    // MARK: Methods
    
    func fetchProducts() {
        let productIdsSet = Set(Array(ShopManager.ProductIdWithDollars.keys))
        productsRequest = SKProductsRequest(productIdentifiers: productIdsSet)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func purchaseProduct(withIdentifier identifier: String, onComplete: @escaping CompletionHandler) {
        for product in products {
            if identifier == product.productIdentifier {
                if SKPaymentQueue.canMakePayments() && products.count > 0 {
                    transactionComplete = onComplete
                    let payment = SKPayment(product: product)
                    SKPaymentQueue.default().add(payment)
                    return
                }
            }
        }
        onComplete(false)
    }
    
    func restorePurchases(onComplete: @escaping CompletionHandler) {
        
        if SKPaymentQueue.canMakePayments() {
            transactionComplete = onComplete
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else {
            onComplete(false)
        }
    }
    
    func restorePurchase() -> Void {
        SwiftSpinner.show("Restoring purchase...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


// MARK: SKProductsRequestDelegate

extension StoreKitManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            //print(response.products.debugDescription)
            products = response.products
        }
        
        restorePurchases { (success) in
            
        }
    }
}


// MARK: SKPaymentTransactionObserver

extension StoreKitManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            case .failed:
                //print(">>> failed")
                SwiftSpinner.hide()
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete?(false)
                break
            case .purchased:
                //print(">>> purchased")
                fallthrough
            case .restored:
                //print("TransactionState: \(transaction.transactionDate?.debugDescription)")
                if transaction.transactionState == .restored {
                    //print(">>> restored")
                }
                SwiftSpinner.hide()
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete?(true)
            case .purchasing:
                //print(">>> purchasing")
                //SKPaymentQueue.default().restoreCompletedTransactions()
                break
            case .deferred:
                //print(">>> deferred")
                break
            }
        }
        //print(">>> DONE")
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            let payment: SKPaymentTransaction = transaction
            let removeAds = payment.payment.productIdentifier as String
            
            if removeAds == "com.gameclub.joywar.removeads" {
                self.delegate?.removeAds()
                break
            }
        }
    }
}
