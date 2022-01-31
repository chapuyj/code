//
//  4_UnstructuredTask_Tests.swift
//  
//
//  Created by Chapuy Jordan on 31/01/2022.
//

import XCTest
@testable import async_await

final class UnstructuredTask_Tests: XCTestCase {
        
    func test_create_task() async {
        let handle = Task {
            return await loadUrls()
        }
        let result = await handle.value
        XCTAssertEqual(result, [
            "https://jordanchapuy.com",
            "https://google.com"
        ])
    }
    
    func test_isCancelled() async throws {
        let handle: Task<String, Error> = Task {
            do {
                let _ = try await fetch(url: "https://jordanchapuy.com")
                
                if Task.isCancelled {
                    // an opportunity to clean/close things
                    // then return default value
                    return "aborted"
                }
                
                return "complex async things with data..."
            } catch {
                return "aborted"
            }
        }
        
        handle.cancel()
        
        let result = try await handle.value
        XCTAssertEqual(result, "aborted")
    }
    
    func test_checkCancellation() async throws {
        let handle: Task<String, Error> = Task {
            let _ = try await fetch(url: "https://jordanchapuy.com")
                        
            // an opportunity to not start new complex things
            try Task.checkCancellation()
            
            return "complex async things with data..."
        }
        
        handle.cancel()
        
        await assertAsyncThrowsError {
            let result = try await handle.value
            print(result)
        }
    }
}
