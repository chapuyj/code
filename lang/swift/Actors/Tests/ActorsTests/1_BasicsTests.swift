import XCTest
@testable import Actors

final class BasicsTests: XCTestCase {
    
    func test_actorIsEasilyUsed() async {
        let account = BankAccount()
        
        await account.deposit(70)
        await account.deposit(30)
        await account.withdraw(10)
        
        let balance = await account.balance
        XCTAssertEqual(balance, 90)
    }
        
    func test_actorIsPassedByReference() async {
        let paySalary = { (account: BankAccount) in
            await account.deposit(10)
        }
        
        let account = BankAccount()
        
        await paySalary(account)
        
        let balance = await account.balance
        XCTAssertEqual(balance, 10)
    }
    
    func test_actorsAreIndependant_noSingleton() async {
        await BankAccount().deposit(117)
        await BankAccount().deposit(343)
        
        let balance = await BankAccount().balance
        XCTAssertEqual(balance, 0)
    }
}
