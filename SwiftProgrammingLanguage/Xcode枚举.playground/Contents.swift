//: Playground - noun: a place where people can play

import Cocoa

//枚举语法  case关键词表明新的一行成员值将被定义。
enum CompassPoint1 {
    case North
    case South
    case East
    case West
}

enum Planet1 {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


var directionToHead = CompassPoint1.West
//先设置成上面的样子 才能简写

directionToHead = .East

directionToHead = .South

switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}
// 输出 "Watch out for penguins”


enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}


var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}
// 输出 "QR code: ABCDEFGHIJKLMNOP."


//如果一个枚举成员的所有相关值被提取为常量，或者它们全部被提取为变量，为了简洁，你可以只放置一个var或者let标注在成员名称前：
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
    print("QR code: \(productCode).")
}
// 输出 "QR code: ABCDEFGHIJKLMNOP."

//原始值（Raw Values）
//原始值可以是字符串，字符，或者任何整型值或浮点型值。每个原始值在它的枚举声明中必须是唯一的。
//原始值和相关值是不相同的。当你开始在你的代码中定义枚举的时候原始值是被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终是相同的。相关值是当你在创建一个基于枚举成员的新常量或变量时才会被设置，并且每次当你这么做得时候，它的值可以是不同的。
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

//当使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个值没有被赋初值，将会被自动置为0。
//
enum Planet: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

//当使用字符串作为枚举类型的初值时，每个枚举成员的隐式初值则为该成员的名称
enum CompassPoint: String {
    case North, South, East, West
}
CompassPoint.South

//使用枚举成员的rawValue属性可以访问该枚举成员的原始值：
let earthsOrder = Planet.Earth.rawValue
// earthsOrder 值为 3

let sunsetDirection = CompassPoint.West.rawValue
// sunsetDirection 值为 "West"

//使用原始值来初始化(Initializing from a Raw Value)
//如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法将原始值类型作为参数，返回枚举成员或者nil。你可以使用这种初始化方法来创建一个新的枚举变量。

//这个例子通过原始值7从而创建枚举成员：
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet 类型为 Planet? 值为 Planet.Uranus

let positionToFind = 5
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// 输出 "There isn't a planet at position 9

//递归枚举（Recursive Enumerations）
//递归枚举（recursive enumeration）是一种枚举类型，表示它的枚举中，有一个或多个枚举成员拥有该枚举的其他成员作为相关值。使用递归枚举时，编译器会插入一个中间层。你可以在枚举成员前加上indirect来表示这成员可递归。

enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
//你也可以在枚举类型开头加上indirect关键字来表示它的所有成员都是可递归的：


func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// 计算 (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(sum))
print(evaluate(product))
// 输出 "18"
