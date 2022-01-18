//
//  3_TaskGroup.swift
//  
//
//  Created by Chapuy Jordan on 17/01/2022.
//

import Foundation

protocol Network {
    func ping(url: String) async
    func fetch(url: String) async throws -> Data
}

class MyTaskGroup {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func ping() async {
        
        await withTaskGroup(of: Void.self) { taskGroup in
            let urls = await loadUrls()
            
            for url in urls {
                taskGroup.addTask(priority: .low) {
                    await self.network.ping(url: url)
                }
            }
        }
    }
    
    func fetchingHttp() async throws -> [Data] {
        try await withThrowingTaskGroup(of: Data.self, returning: [Data].self) { taskGroup in
            let urls = await loadUrls()
            
            for url in urls {
                taskGroup.addTask {
                    return try await self.network.fetch(url: url)
                }
            }
            
            return try await taskGroup.giveMyThrowingResults()
        }
    }
    
    /// If one child task throws, the whole group will throw.
    func fetchingWithOneError() async throws -> [Data] {
        try await withThrowingTaskGroup(of: Data.self, returning: [Data].self) { taskGroup in
            let numbers = [0, 2, 4, -5]
            
            for number in numbers {
                taskGroup.addTask(priority: .low) {
                    if number < 0 {
                        return try await throwingError() // will fail
                    } else {
                        return try await self.network.fetch(url: String(number)) // will succeed
                    }
                }
            }
                    
            return try await taskGroup.giveMyThrowingResults()
        }
    }
}

extension TaskGroup {
    // Really? Another solution?
    func giveMyResults() async -> [Element] {
        var results = [Element]()
        for await result in self {
            results.append(result)
        }
        return results
    }
}

extension ThrowingTaskGroup {
    // Really? Another better solution?
    func giveMyThrowingResults() async throws -> [Element] {
        var results = [Element]()
        for try await result in self {
            results.append(result)
        }
        return results
    }
}
