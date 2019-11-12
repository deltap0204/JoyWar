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
    func updateWithProducts(products: [SKProduct])
    func refreshPurchaseStatus(purchasedDollars: Int)
    func purchaseFailed(reason: String)
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
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
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
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
    
    func purchaseProduct(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
}

extension StoreManager: SKProductsRequestDelegate {
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        loadedProducts = response.products
        if loadedProducts.count != 0 {
            delegate?.updateWithProducts(loadedProducts)
        }
    }
}

extension StoreManager: SKPaymentTransactionObserver {
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let paymentTransaction:SKPaymentTransaction = transaction as? SKPaymentTransaction {
                switch paymentTransaction.transactionState {
                    
                case .Purchased:
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    let purchasedDollars = ProductDelivery.deliverProduct(paymentTransaction.payment.productIdentifier)
                    delegate?.refreshPurchaseStatus(purchasedDollars)
                    break
                    
                case .Failed:
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    delegate?.purchaseFailed(transaction.error!!.description)
                    break
                    
                case .Restored:
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
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
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.locale = priceLocale
        return currencyFormatter.stringFromNumber(price)!
    }
}