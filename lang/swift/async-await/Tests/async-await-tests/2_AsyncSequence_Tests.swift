//
//  2_AsyncSequence_Tests.swift
//  
//
//  Created by Chapuy Jordan on 17/01/2022.
//

import XCTest
@testable import async_await

final class AsyncSequence_Tests: XCTestCase {

    // MARK: - Creating an AsyncSequence
    
    func test_creatingSimpleAsyncSequence() async {
        var results = [Int]()
        
        for await digit in DigitGenerator() {
            results.append(digit)
        }
        
        XCTAssertEqual(results, [0,1,2,3,4,5,6,7,8,9])
    }
}
