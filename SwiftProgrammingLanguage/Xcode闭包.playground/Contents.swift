//: Playground - noun: a place where people can play

import Cocoa

//闭包可以捕获和存储其所在上下文中任意常量和变量的引用。 这就是所谓的闭合并包裹着这些常量和变量，俗称闭包。
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

//因此排序闭包函数类型需为(String, String) -> Bool
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)
// reversed 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

/*闭包表达式语法（Closure Expression Syntax）
{ (parameters) -> returnType in
    statements
}
*/

//各种闭包的缩写

//闭包表达式语法可以使用常量、变量和inout类型作为参数， 不提供默认值。 也可以在参数列表的最后使用可变参数。 元组也可以作为参数和返回值。
var reversed1 = names.sort({ (let s1: String, s2: String) -> Bool in
    return s1 > s2
})

//根据上下文推断类型（Inferring Type From Context）
var reversed2 = names.sort( { s1, s2 in return s1 > s2 } )

//单表达式闭包隐式返回（Implicit Return From Single-Expression Clossures）
reversed = names.sort( { s1, s2 in s1 > s2 } )

//参数名称缩写（Shorthand Argument Names）
reversed = names.sort( { $0 > $1 } )

//运算符函数（Operator Functions）
reversed = names.sort(>)



//尾随闭包  函数支持将其作为最后一个参数调用。
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure({
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}

//如果函数只需要闭包表达式一个参数，当您使用尾随闭包时，您甚至可以把()省略掉。
reversed = names.sort() { $0 > $1 }
reversed = names.sort { $0 > $1 }

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
// strings 常量被推断为字符串类型数组，即 [String]
// 其值为 ["OneSix", "FiveEight", "FiveOneZero"]

//捕获值（Capturing Values）
//闭包可以在其定义的上下文中捕获常量或变量。 即使定义这些常量和变量的原域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)

incrementByTen()
incrementByTen()
incrementByTen()

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// 返回的值为40

//如果您创建了另一个incrementor，其会有一个属于自己的独立的runningTotal变量的引用。 下面的例子中，incrementBySevne捕获了一个新的runningTotal变量，该变量和incrementByTen中捕获的变量没有任何联系：
let incrementBySeven = makeIncrementor(forIncrement: 7)

incrementBySeven()
// 返回的值为7

incrementByTen()
// 返回的值为50

//注意： 如果您将闭包赋值给一个类实例的属性，并且该闭包通过指向该实例或其成员来捕获了该实例，您将创建一个在闭包和实例间的强引用环。 Swift 使用捕获列表来打破这种强引用环。更多信息，请参考 闭包引起的循环强引用。



