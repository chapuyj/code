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

extension Sequence {
    func assertIsContained(in expression: @autoclosure () -> [Element], file: StaticString = #filePath, line: UInt = #line) where Element: Equatable {
        
        let succeed = self.allSatisfy(expression().contains)
        XCTAssertTrue(succeed)
    }
}
