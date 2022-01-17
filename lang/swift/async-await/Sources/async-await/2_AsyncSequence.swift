//
//  2_AsyncSequence.swift
//  
//
//  Created by Chapuy Jordan on 17/01/2022.
//

import Foundation

// MARK: - Creating an AsyncSequence

struct DigitGenerator: AsyncSequence, AsyncIteratorProtocol {

    typealias Element = Int
    private var current = 0
    
    mutating func next() async -> Element? {
        defer { current += 1 }
        
        if current <= 9 {
            return current
        } else {
            return nil
        }
    }
    
    func makeAsyncIterator() -> DigitGenerator {
        self
    }
}
