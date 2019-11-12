//
//  Stack.swift
//  Game
//
//  Created by Developer on 18.05.17.
//  Copyright © 2017 Daniel Slupskiy. All rights reserved.
//

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
    
    public mutating func clear(){
    
    array.removeAll()
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator { _ -> T? in
            return curr.pop()
        }
    }
}
