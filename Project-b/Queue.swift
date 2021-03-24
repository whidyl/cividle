//
//  Queue.swift
//  Project-b
//
//  Created by Dylan Whitehurst on 3/23/21.
//

import Foundation

public struct Queue<T> {
    fileprivate var list = LinkedList<T>()
    
    public mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else { return nil }
        return list.remove(element)
    }
    
    public func peek() -> T? {
        return list.first?.value
    }
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
}

extension Queue: CustomStringConvertible {
  public var description: String {
    return list.description
  }
}
