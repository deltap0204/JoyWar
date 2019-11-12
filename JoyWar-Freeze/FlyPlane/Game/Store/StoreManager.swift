//
//  StoreManager.swift
//  FlyPlane
//
//  Created by Dexter on 04/06/16.
//  Copyright © 2016 Studio2Entertainment. All rights reserved.
//

import Foundation
import StoreKit

protocol StoreManagerDelegate {
    func updateWithProducts(_ products: [SKProduct])
    func refreshPurchaseStatus(_ purchasedDollars: Int)
    func purchaseFailed(_ reason: String)
}

class StoreManager: NSObject {
    
    var delegate: StoreManagerDelegate?
    var loadedProducts: [SKProduct] = []
    var isTransactionObserverAdded = Bool()
    
    static let sharedInstance = StoreManager()
    
    override init() {
        super.init()
        
        if !isTransactionObserverAdded {
            addTransactinObserver()
        }
        getProducts()
    }
    
    func addTransactinObserver() {
        SKPaymentQueue.default().add(self)
        isTransactionObserverAdded = true
    }
    
    func getProducts() {
        if SKPaymentQueue.canMakePayments() {
            let products = NSSet(array: Products.availableProducts)
            let productRequest = SKProductsRequest(productIdentifiers: products as! Set<String>)
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    func restoreCompletedTransactions() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func purchaseProduct(_ product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
}

extension StoreManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        loadedProducts = response.products
        if loadedProducts.count != 0 {
            delegate?.updateWithProducts(loadedProducts)
        }
    }
}

extension StoreManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let paymentTransaction:SKPaymentTransaction = transaction as? SKPaymentTransaction {
                switch paymentTransaction.transactionState {
                    
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    let purchasedDollars = ProductDelivery.deliverProduct(paymentTransaction.payment.productIdentifier)
                    delegate?.refreshPurchaseStatus(purchasedDollars)
                    break
                    
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if let error = transaction.error {
                        delegate?.purchaseFailed(error.debugDescription)
                    } else {
                        print("Unknown error")
                    }
                    
                    break
                    
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    ProductDelivery.deliverProduct(paymentTransaction.payment.productIdentifier)
                    break
                    
                default:
                    break
                }
            }
        }
    }
}

extension SKProduct {
    func localizedPrice() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = priceLocale
        return currencyFormatter.string(from: price)!
    }
}
