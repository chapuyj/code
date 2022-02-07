import Foundation

class ProblematicBankAccount {
    
    private(set) var balance: Int = 100
    
    func withdraw(_ amount: Int) {
        balance -= amount
    }
}

actor ActorBankAccount {
    
    private(set) var balance: Int = 100
    
    func withdraw(_ amount: Int) {
        balance -= amount
    }
}

class Worker {
    
    private let queue: OperationQueue
    private let balance: () -> Int
    private let withdraw: () -> Void
    
    init(balance: @escaping () -> Int, withdraw: @escaping () -> Void) {
        self.balance = balance
        self.withdraw = withdraw
        self.queue = OperationQueue()
        queue.maxConcurrentOperationCount = 100
        queue.qualityOfService = .userInitiated
    }
    
    func add() {
        for _ in 0..<1000 {
            queue.addOperation {
                let balance = self.balance()
                Thread.sleep(forTimeInterval: 0.1)
                
                if balance > 0 {
                    self.withdraw()
                }
            }
        }
    }
}

class ActorWorker {
    
    private let account: ActorBankAccount
    
    init(account: ActorBankAccount) {
        self.account = account
    }
    
    func add() async {
        let _ = await withTaskGroup(of: Void.self) { group in
            for _ in 0..<1000 {
                group.addTask {
                    let balance = await self.account.balance
                    Thread.sleep(forTimeInterval: 0.01)
                    
                    if balance > 0 {
                        await self.account.withdraw(1)
                    }
                }
            }
        }
    }
}
