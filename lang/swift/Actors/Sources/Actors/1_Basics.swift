actor BankAccount {
    
    private(set) var balance: Int = 0
    
    func deposit(_ amount: Int) {
        balance += amount
    }
    
    func withdraw(_ amount: Int) {
        balance -= amount
    }
}
