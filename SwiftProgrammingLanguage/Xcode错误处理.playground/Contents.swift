//: Playground - noun: a place where people can play

import Cocoa
//和java类似
//枚举和ErrorType协议结合使用
enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(required: Double)
    case OutOfStock
}

//方法抛出  func canThrowErrors() throws -> String

struct Item {
    var price: Double
    var count: Int
}

var inventory = [
    "Candy Bar": Item(price: 1.25, count: 7),
    "Chips": Item(price: 1.00, count: 4),
    "Pretzels": Item(price: 0.75, count: 11)
]
var amountDeposited = 1.00

func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
        throw VendingMachineError.InvalidSelection //手动抛出错误
    }
    
    guard item.count > 0 else {
        throw VendingMachineError.OutOfStock  //手动抛出错误

    }
    
    if amountDeposited >= item.price {
        // Dispense the snack
        amountDeposited -= item.price
        --item.count
        inventory[name] = item
    } else {
        let amountRequired = item.price - amountDeposited
        throw VendingMachineError.InsufficientFunds(required:   amountRequired)
    }
}

//当调用一个抛出函数的时候，在调用前面加上try。这个关键字表明函数可以抛出错误，而且在try后面代码将不会执行。
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

//这个函数会调用vend函数，vend函数可能会抛出错误，所以在vend前面加上了try关键字。因为buyFavoriteSnack函数也是一个抛出函数，所以vend函数抛出的任何错误都会向上传递到buyFavoriteSnack被调用的地方。
func buyFavoriteSnack(person: String) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar" //空和运算符
        do{
            try vend(itemNamed: snackName)

        }catch VendingMachineError.InsufficientFunds(required: 12) {
        
        }
    }

//捕捉和处理错误
/*
do {
    
    try buyFavoriteSnack that throws
    
    statements
    
} catch pattern {
    
    statements
    
}
*/


//禁止错误传播
//forced-try表达式来调用抛出函数或方法，即使用try!来代替try。
//通过try!来调用抛出函数或方法禁止了错误传送，并且把调用包装在运行时断言，这样就不会抛出错误。如果错误真的抛出了，会触发运行时错误。
func willOnlyThrowIfTrue(value: Bool) throws {
    if value { throw someError }
}

do {
    try willOnlyThrowIfTrue(false)
} catch {
    // Handle Error
}

try! willOnlyThrowIfTrue(false)


//收尾操作
//defer语句把执行推迟到退出当前域的时候。类似java的finally
//被推迟的语句可能不包含任何将执行流程转移到外部的代码，比如break或者return语句
//被推迟的操作的执行的顺序和他们定义的顺序相反，也就是说，在第一个defer语句中的代码在第二个defer语句中的代码之后执行。

func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
//上面这个例子使用了defer语句来保证open有对应的close。这个调用不管是否有抛出都会执行。




