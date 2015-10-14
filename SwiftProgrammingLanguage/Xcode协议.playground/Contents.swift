//: Playground - noun: a place where people can play

import Cocoa


//如果类在遵循协议的同时拥有父类，应该将父类名放在协议名之前，以逗号分隔。

//protocol SomeProtocol {
//    var mustBeSettable : Int { get set } //可读写属性
//    var doesNotNeedToBeSettable: Int { get } //只能读
//}

//在协议中定义类属性(type property)时，总是使用static关键字作为前缀。
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}


//对方法的规定
//协议中定义类方法的时候，总是使用static关键字作为前缀。
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// 输出 : "Here's a random number: 0.37464991998171"
print("And another one: \(generator.random())")
// 输出 : "And another one: 0.729023776863283"

//对Mutating方法的规定
//注意:
//用类实现协议中的mutating方法时，不用写mutating关键字;用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
//lightSwitch 现在的值为 .On


//对构造器的规定
protocol SomeProtocol {
    init(someParameter: Int)
}

//协议构造器规定在类中的实现
//你可以在遵循该协议的类中实现构造器，并指定其为类的指定构造器(designated initializer)或者便利构造器(convenience initializer)。在这两种情况下，你都必须给构造器实现标上"required"修饰符：
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        //构造器实现
    }
}
//注意
//如果类已经被标记为final，那么不需要在协议构造器的实现中使用required修饰符。因为final类不能有子类。关于final修饰符的更多内容，请参见防止重写。

//如果一个子类重写了父类的指定构造器，并且该构造器遵循了某个协议的规定，那么该构造器的实现需要被同时标示required和override修饰符
protocol SomeProtocol1 {
    init()
}

class SomeSuperClass1 {
    init() {
        // 构造器的实现
    }
}

class SomeSubClass: SomeSuperClass1, SomeProtocol1 {
    // 因为遵循协议，需要加上"required"; 因为继承自父类，需要加上"override"
    required override init() {
        // 构造器实现
    }
}

//注意
//协议是一种类型，因此协议类型的名称应与其他类型(Int，Double，String)的写法相同，使用大写字母开头的驼峰式写法，例如(FullyNamed和RandomNumberGenerator)
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

















