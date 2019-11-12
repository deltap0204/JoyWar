//
//  Queue.swift
//  Game
//
//  Created by Developer on 17.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

import Foundation

public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
        
       /* if count>1 {array.removeFirst()
        //print("////////////////\n PaFa deleted \n/////////")
        
        }*/

    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
    
    public var last: T? {
        return array.last
    }
    
    public mutating func replace(_ element: T, index: Int){
       array[index] = element
    }
    public func getElement(forIndex: Int) ->T?{
        return array[forIndex]
    }
}
