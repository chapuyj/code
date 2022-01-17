//
//  File.swift
//  
//
//  Created by Chapuy Jordan on 17/01/2022.
//

import XCTest

func assertAsyncThrowsError(_ expression: @escaping () async throws -> Void, file: StaticString = #filePath, line: UInt = #line) async {
    do {
        _ = try await expression()
        XCTFail("Should throw an error.")
    } catch {
        XCTAssertTrue(true)
    }
}
