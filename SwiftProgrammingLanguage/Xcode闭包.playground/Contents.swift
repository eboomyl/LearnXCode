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

//闭包是引用类型（Closures Are Reference Types）
//无论您将函数或闭包赋值给一个常量还是变量，您实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用incrementByTen是一个常量，而并非闭包内容本身。

//非逃逸闭包(Nonescaping Closures)
  //当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注@noescape，用来指明这个闭包是不允许“逃逸”出这个函数的。将闭包标注@noescape能使编译器知道这个闭包的生命周期（译者注：闭包只能在函数体中被执行，不能脱离函数体执行，所以编译器明确知道运行时的上下文），从而可以进行一些比较激进的优化。

func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
    closure()
}

//一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。例如：

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
    completionHandlers.append(completionHandler)
}
//典型的例子有
//let  userLogin  = UIAlertAction(title: "点击进入", style: UIAlertActionStyle.Default,  handler: {
//               action in
//})

//自动闭包（Autoclosures）
//自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够用一个普通的表达式来代替显式的闭包，从而省略闭包的花括号。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// prints "5"

//申明闭包的引用，并没有实际执行移除操作
let customerProvider = { customersInLine.removeAtIndex(0) }
print(customersInLine.count)
// prints "5"

//移除操作后，值才会变
print("Now serving \(customerProvider())!")
// prints "Now serving Chris!"
print(customersInLine.count)
// prints "4"
//尽管在闭包的代码中，customersInLine的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会被移除。请注意，customerProvider的类型不是String，而是() -> String，一个没有参数且返回值为String的函数。



//将闭包作为参数传递给函数时，你能获得同样的延时求值行为
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serveCustomer(customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer( { customersInLine.removeAtIndex(0) } )
// prints "Now serving Alex!"


//@autoclosure特性。  少写花括号
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serveCustomer(@autoclosure customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer(customersInLine.removeAtIndex(0))   //少写花括号
// prints "Now serving Ewa!"

//@autoclosure特性暗含了@noescape特性，这个特性在非逃逸闭包一节中有描述。如果你想让这个闭包可以“逃逸”，则应该使用@autoclosure(escaping)特性.

// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customersInLine.removeAtIndex(0))

print("Collected \(customerProviders.count) closures.")
// prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// prints "Now serving Barry!"
// prints "Now serving Daniella!"
//在上面的代码中，collectCustomerProviders(_:)函数并没有调用传入的customerProvider闭包，而是将闭包追加到了customerProviders数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包将会在函数返回之后被调用。因此，customerProvider参数必须允许“逃逸”出函数作用域。















