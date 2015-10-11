//: Playground - noun: a place where people can play

import Cocoa

//注意：
//当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观测器（property observers）。

//构造器 init() {}
//类和结构体在实例创建时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0//属性必须被初始化
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// 输出 "The default temperature is 32.0° Fahrenheit”

//所以在调用构造器时，主要通过构造器中的参数名和类型来确定需要调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名，就相当于在每个构造参数之前加了一个哈希符号。

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}


struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){//不带外部名的构造器参数
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius 为 37.0

//可选属性类型
class SurveyQuestion {
    var text: String
    var response: String?//逻辑上允许取值为空的存储型属性
    init(text: String) {
        self.text = text//非可选类型的必须初始化
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// 输出 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."

//注意：
//对某个类实例来说，它的常量属性只能在定义它的类的构造过程中(init中)修改；不能在子类中修改。

//默认构造器  就是所有属性设置默认值
class ShoppingListItem1 {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem1()

//结构体的逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

//值类型（结构体和枚举类型）不支持继承
//类则不同，它可以继承自其它类（请参考继承），这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
//对于值类型，你可以使用self.init在自定义的构造器中引用其它的属于相同值类型的构造器。并且你只能在构造器内部调用self.init。

//假如你想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型创建实例，我们建议你将自己定制的构造器写到扩展（extension）中，而不是跟值类型定义混在一起。想查看更多内容，请查看扩展章节。


//构造器调用构造器 称为代理 进行初始化
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//类里面的所有存储型属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值。这就是为什么需要 super.init()


/*

指定构造器
init(parameters) {
    statements
}

你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。
你也可以定义便利构造器来创建一个特殊用途或特定输入的实例。

便利构造器
convenience init(parameters) {
    statements
}

//类的构造器代理规则
规则 1

指定构造器必须调用其直接父类的的指定构造器。

规则 2

便利构造器必须调用同一类中定义的其它构造器。

规则 3

便利构造器必须最终以调用一个指定构造器结束。

一个更方便记忆的方法是：
.指定构造器必须总是向上代理
.便利构造器必须总是横向代理

*/


//两段式构造过程
//Swift 中类的构造过程包含两个阶段。第一个阶段，每个存储型属性通过引入它们的类的构造器来设置初始值。当每一个存储型属性值被确定后，第二阶段开始，它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。


/*
  Swift 编译器将执行 4 种有效的安全检查

1. 一个类的所有属性必须初始化完成以后，才能调用父类的构造器
2. 指定构造器 必须先执行父类的构造器后，才能设置继承的属性的值，要不继承的属性值会被覆盖
3. 便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
4. 构造器在第一阶段构造完成之前，不能调用任何实例方法、不能读取任何实例属性的值，self的值不能被引用。

阶段 1

某个指定构造器或便利构造器被调用；
完成新实例内存的分配，但此时内存还没有被初始化；
指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化；
指定构造器将调用父类的构造器，完成父类属性的初始化；
这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部；
当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段1完成。


阶段 2
从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。

*/


//构造器的继承和重写
//Swift 中的子类不会默认继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更专业的子类继承，并被错误的用来创建子类的实例。
//注意 子类可以在初始化时修改继承变量属性，但是不能修改继承过来的常量属性。

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
    
}

class Bicycle: Vehicle {
    var test1: Int
    override init() {
        self.test1 = 2  //子类的属性初始化必须先与父类的init()
        super.init()
        numberOfWheels = 2//继承的属性必须后于父类的init()
    }
    
}

//自动构造器的继承
/*

规则 1

如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。

规则 2

如果子类提供了所有父类指定构造器的实现--不管是通过规则1继承过来的，还是通过自定义实现的--它将自动继承所有父类的便利构造器。

注意：
子类可以通过部分满足规则2的方式，使用子类便利构造器来实现父类的指定构造器。

*/
//若有指定构造器，则默认构造器不存在了
//接下来的例子将在操作中展示指定构造器、便利构造器和自动构造器的继承。
class Food {
    var name: String
    init(name: String) {//没有提供一个默认的逐一成员构造器，所以Food类提供了一个接受单一参数name的指定构造器。
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
// namedMeat 的名字是 "Bacon”

let mysteryMeat = Food()//通过便利构造器初始化
// mysteryMeat 的名字是 [Unnamed]

//注意，RecipeIngredient的便利构造器init(name: String)使用了跟Food中指定构造器init(name: String)相同的参数。因为这个便利构造器重写要父类的指定构造器init(name: String)，必须在前面使用使用override标识（参见构造器的继承和重写）。
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}


let oneMysteryItem = RecipeIngredient()//这个便利构造器是继承而来  规则2--208行
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {//规则1：它将自动继承所有父类的指定构造器。
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name.lowercaseString)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x orange juice ✔
// 1 x bacon ✘
// 6 x eggs ✘



//可失败构造器

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// 打印 "This is not a defined temperature unit, so initialization failed."


//带原始值的枚举类型的可失败构造器
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")//rawValue的默认参数
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit1 = TemperatureUnit1(rawValue: "X")//rawValue的默认参数
if unknownUnit1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// prints "This is not a defined temperature unit, so initialization failed."


//类的可失败构造器只能在所有的类属性被初始化后和所有类之间的构造器之间的代理调用发生完后触发失败行为。
class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }//必须放在对属性初始化完成后才能进行
    }
}

if let bowTie = Product(name: "bow tie") {
    // 不需要检查 bowTie.name == nil
    print("The product's name is \(bowTie.name)")
}
// 打印 "The product's name is bow tie"


//构造失败的传递
//注意： 可失败构造器也可以代理调用其它的非可失败构造器。通过这个方法，你可以为已有的构造过程加入构造失败的条件。
class CartItem: Product {
    var quantity: Int! //使用let 声明的话会报错 ，本身可选类型默认初始化nil
    init?(name: String, quantity: Int) {
        super.init(name: name)
        if quantity < 1 { return nil }
        self.quantity = quantity
    }
}
//如果由于name的值为空而导致基类的构造器在构造过程中失败。则整个CartIem类的构造过程都将失败，后面的子类的构造过程都将不会被执行。如果基类构建成功，则继续运行子类的构造器代码。


if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// 打印 "Item: sock, quantity: 2"


if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// 打印 "Unable to initialize zero shirts"


if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// 打印 "Unable to initialize one unnamed product"


//重写一个可失败构造器
//你也可以用子类的可失败构造器重写基类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个基类的可失败构造器。
//即使基类的构造器为可失败构造器，但当子类的构造器在构造过程不可能失败时，我们也可以把它修改过来。
//注意当你用一个子类的非可失败构造器重写了一个父类的可失败构造器时，子类的构造器将不再能向上代理父类的可失败构造器。一个非可失败的构造器永远也不能代理调用一个可失败构造器。
//注意： 你可以用一个非可失败构造器重写一个可失败构造器，但反过来却行不通。
class Document {
    var name: String?
    // 该构造器构建了一个name属性值为nil的document对象
    init() {}
    // 该构造器构建了一个name属性值为非空字符串的document对象
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//可失败构造器 init!  直接吧可选类型若为非nil的直接解析
//该可失败构造器将会构建一个特定类型的隐式解析可选类型的对象。


//必要构造器  required
//在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器：
//在重写基类的必要构造器时，不需要添加override修饰符：
class SomeClass {
    required init() {
        // 在这里添加该必要构造器的实现代码
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // 在这里添加子类必要构造器的实现代码
    }
}

/*
//通过闭包和函数来设置属性的默认值

class SomeClass1 {
    let someProperty: SomeType = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
        }()
}


注意：
如果你使用闭包来初始化属性的值，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能够在闭包里访问其它的属性，就算这个属性有默认值也不允许。同样，你也不能使用隐式的self属性，或者调用其它的实例方法。
*/
//闭包例子
//注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
class SomeClassClosePacage{
    let somePorperty: String  = {
        return "test"
    }()
}


struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
        }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))
// 输出 "true"
print(board.squareIsBlackAtRow(9, column: 9))
// 输出 "false"
