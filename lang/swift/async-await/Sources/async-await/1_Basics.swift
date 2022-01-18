//
//  1_Basics.swift
//  
//
//  Created by Chapuy Jordan on 17/01/2022.
//

import Foundation

// MARK: - Creating async functions

func loadUrls() async -> [String] {
    return [
        "https://jordanchapuy.com",
        "https://google.com"
    ]
}

extension Array {
    func asyncCount() async -> Int {
        return count
    }
}

func fetch(url: String) async throws -> Data {
    let url = URL(string: url)!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

enum MyError: Error {
    case sorryNotSorry
}

func throwingError() async throws -> Data {
    throw MyError.sorryNotSorry
}

// MARK: - Wrapping closure into async

func numberClosure(completion: @escaping ((Int) -> Void)) {
    return completion(343)
}

func numberAsyncWrapper() async -> Int {
    return await withCheckedContinuation { continuation in
        numberClosure { number in
            continuation.resume(returning: number)
        }
    }
}

func resultClosure(completion: @escaping ((Result<String, Error>) -> Void)) {
    completion(.success("ok"))
}

func resultAsyncWrapper() async throws -> String {
    return try await withCheckedThrowingContinuation { continuation in
        resultClosure { result in
            continuation.resume(with: result)
        }
    }
}

// MARK: - Chain async

func chainingCountUrls() async throws -> Int {
    let urls = await loadUrls()
    let moreUrls = await loadUrls() + urls
    let count = await moreUrls.asyncCount()
    return count
}


// MARK: - Parallels async

func parallelsAsync() async throws -> [Data] {
    async let jordan = fetch(url: "https://jordanchapuy.com")
    async let google = fetch(url: "https://google.com")
    return try await [jordan, google]
}

func failingParallelsAsync() async throws -> [Data] {
    async let jordan = fetch(url: "https://jordanchapuy.com")
    async let error = throwingError()
    return try await [jordan, error]
}
