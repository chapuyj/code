//
//  3_TaskGroup_Tests.swift
//  
//
//  Created by Chapuy Jordan on 17/01/2022.
//

import XCTest
@testable import async_await

final class TaskGroup_Tests: XCTestCase {
        
    func test_pingReturnNever() async {
        let network = TestNetwork()
        let group = MyTaskGroup(network: network)
        
        await group.ping()
                        
        network.pingedUrls.assertIsContained(in: [
            "https://google.com",
            "https://jordanchapuy.com"
        ])
    }
    
    func test_fetchingReturnData() async throws {
        let network = TestNetwork()
        let group = MyTaskGroup(network: network)
        
        let datas = try await group.fetchingHttp()
                        
        network.fetchedUrls.assertIsContained(in: [
            "https://google.com",
            "https://jordanchapuy.com"
        ])
        XCTAssertEqual(datas.count, 2)
    }
    
    func test_fetchingWithOneError_FailsTheWholeGroup() async throws {
        let network = TestNetwork()
        let group = MyTaskGroup(network: network)
        
        await assertAsyncThrowsError {
            _ = try await group.fetchingWithOneError()
        }
    }
}

class TestNetwork: Network {
    
    private(set) var pingedUrls = [String]()
    
    func ping(url: String) async {
        pingedUrls.append(url)
    }
    
    private(set) var fetchedUrls = [String]()
    
    func fetch(url: String) async throws -> Data {
        fetchedUrls.append(url)
        return Data()
    }
}
