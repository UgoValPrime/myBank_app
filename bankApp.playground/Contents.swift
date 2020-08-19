
import UIKit

// Account Class
class Account {
    var id: Int = 0
    var customerId: Int
    var accountBalance: Int = 0
    var interest: Double = 0.0
    
    init (customerId: Int) {
        self.customerId = customerId
    }
    
    // Account Methods
    
    //withdrawal
    //Abstraction:
    
    func withdrawal(amount: Int) -> Int {
        if amount * 100 > self.accountBalance || amount * 100 <= 0 {
            print("invalid amount to withdraw")
        } else {
            self.accountBalance -= amount * 100
        }
        return self.accountBalance
    }
    
    // Deposit
    //Abstraction
    func deposit (amount: Int) -> String {
        self.accountBalance += (amount * 100)
        return " Your new account balance is \(self.accountBalance)"
    }
    
    // Charges
    //Abstraction
    
    func charge () -> Int {
        self.accountBalance -= (100 * 100)
        return (self.accountBalance)
    }
    
    // Bonus
    //Abstraction
    func bonus() -> Int {
        self.accountBalance += (10 * 100)
        return (self.accountBalance)
    }
    
}

// Savings Account
//Inheritance

class SavingsAccount: Account {
    // polymorphism
    override var interest: Double{
        get {return 0.1}
        set{}
    }
    // polymorphism
    override func deposit(amount: Int) -> String {
        self.bonus()
        return amount <= 0 ? "deposit must be more than Zero": "Your new acc balance is\(self.accountBalance += (amount * 100))"
    }
}

// current account
//Inheritance
class CurrentAccount: Account{
    // polymorphism
    override var interest: Double{
        get{return 0.05}
        set {}
    }
    // polymorphism
    override func withdrawal(amount: Int) -> Int {
        let amountIncludingChargesKobo = (amount + 100) * 100
        if amount <= 0 {
            print("invalid amount to withdraw")
        } else if amountIncludingChargesKobo > self.accountBalance {
            print("invalid amount to withdraw")
        } else {
            super.withdrawal(amount: amount)
            self.charge()
        }
        return self.accountBalance
   }
}
//customer class
//Encapsulation
var customerIdCount = 1
class Customer {
    private var _id: Int = 0
    private var _name: String
    private var _address: String
    private var _phone_no: Int
    var accounts: [Account]? = []
     
   public var id: Int{
        get{return _id} set{ newValue }
    }
    public var name: String{
        get{return _name} set{ newValue }
    }
    public var address: String{
        get{ return _address} set{ newValue }
    }
    public var phone_no: Int{
        get{ return _phone_no} set{ newValue }
    }
    
    
    init(name: String, address: String, phone_no: Int) {
        customerIdCount += 1
        self._id = customerIdCount
        self._name = name
        self._address = address
        self._phone_no = phone_no
    }
    
    //creating acount
    func OpenAccout(accountType: AccountType) -> [Account]? {
        switch accountType {
            case AccountType.savings:
                let openSavings = SavingsAccount (customerId:self.id)
                accounts?.append(openSavings)
                
            case AccountType.current:
                let openCurrent = CurrentAccount (customerId:self.id)
                accounts?.append(openCurrent)
        }
        return accounts
    }
    
    func deposit(customerAcc: Account, amount: Int) -> Int{
        customerAcc.deposit(amount: amount)
        return customerAcc.accountBalance
    }
    func withdraw(customerAcc: Account, amount: Int) -> Int{
    customerAcc.withdrawal(amount: amount)
    return customerAcc.accountBalance
    }
    func accountBalance(customerAcc: Account) -> Int{
    return customerAcc.accountBalance
    }
    func closeAcc(closingAcc: Account) -> [Account]?{
        accounts?.removeAll(where: {$0 === closingAcc})
        return accounts
    }
}

//account types
enum AccountType {
    case savings
    case current
}


// create a customer
let firstCustomer  = Customer(name: "Aries", address: "Decagon uno", phone_no: 08181895875)

//customer open's account
firstCustomer.OpenAccout(accountType: .savings)
firstCustomer.OpenAccout(accountType: .current)

//customer deposit
firstCustomer.deposit(customerAcc: firstCustomer.accounts?[0] ?? <#default value#>, amount:50)
firstCustomer.deposit(customerAcc: firstCustomer.accounts?[0] ?? <#default value#>, amount:50)

//customer can check account balance
firstCustomer.accountBalance(customerAcc: firstCustomer.accounts?[0] ?? <#default value#>)

firstCustomer.withdraw(customerAcc: firstCustomer.accounts?[1] ?? <#default value#>, amount: 350)




//                  DEFINITIONS!
//ABSTRACTION;Abstraction of Data or Hiding of Information is called Abstraction! or in other words, what are those things that a user is concerned about.
//ENCAPSULATION;Binding of Data and Functions (that manipulate the data) together and keep both safe from outside interference and misuse is called Encapsulation.
//INHERITANCE;Inheritance enables new objects to take on the properties of existing objects. There are different ways in which Inheritance can be done.
//POLYMORPHISM;It is the ability to redefine methods for derived classes. or we can say that object can behave in different forms is call Polymorphism.







