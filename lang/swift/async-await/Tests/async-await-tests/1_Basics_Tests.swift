//
//  File.swift
//  
//
//  Created by Chapuy Jordan on 17/01/2022.
//

import XCTest
@testable import async_await

final class Basics_Tests: XCTestCase {

    // MARK: - Creating async functions
    
    func test_creatingAsyncFunction() async {
        let urls = await loadUrls()
        XCTAssertEqual(urls, [
            "https://jordanchapuy.com",
            "https://google.com"
        ])
    }
    
    func test_creatingAsyncHttpFetching() async throws {
        let data = try await fetch(url: "https://jordanchapuy.com")
        XCTAssertFalse(data.isEmpty)
    }
    
    func test_creatingAsyncThrowingError() async {
        await assertAsyncThrowsError {
            _ = try await throwingError()
        }
    }
    
    // MARK: - Wrapping closure into async
    
    func test_wrappingIntoNotThrowingAsync() async {
        let number = await numberAsyncWrapper()
        XCTAssertEqual(number, 343)
    }
    
    func test_wrappingIntoThrowingAsync() async throws {
        let result = try await resultAsyncWrapper()
        XCTAssertEqual(result, "ok")
    }
    
    // MARK: - Chain async
    
    func test_chainingAsync() async throws {
        let count = try await chainingCountUrls()
        XCTAssertEqual(count, 4)
    }
    
    // MARK: - Parallels async
    
    func test_parallelsAsync() async throws {
        let datas = try await parallelsAsync()
        XCTAssertEqual(datas.count, 2)
    }
    
    func test_oneThrowingInParallelsAsync_theWholeIsThrowing() async {
        await assertAsyncThrowsError {
            _ = try await failingParallelsAsync()
        }
    }
}
