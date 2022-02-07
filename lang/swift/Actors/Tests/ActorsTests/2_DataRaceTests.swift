import XCTest
@testable import Actors

final class DataRaceTests: XCTestCase {
    
    func test_simpleClassCausesDataRace() async throws {
        let account = ProblematicBankAccount()
        
        let worker = Worker {
            return account.balance
        } withdraw: {
            account.withdraw(1)
        }

        worker.add()        
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        XCTAssertLessThan(account.balance, 0)
    }
    
    func test_actorPreventsDataRace() async {
        let account = ActorBankAccount()
        let worker = ActorWorker(account: account)

        await worker.add()
        
        let balance = await account.balance
        XCTAssertEqual(balance, 0)
    }
}
