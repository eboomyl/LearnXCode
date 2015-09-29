//
//  SwiftProgrammingLanguage.swift
//  SwiftProgrammingLanguage
//
//  Created by yuanlin on 15/8/23.
//  Copyright (c) 2015年 yuanlin. All rights reserved.
//

import Foundation

class  SwiftProgrammingLanguage {
    //简单值   使用let来声明常量，使用var来声明变量
    func test(){
        var myVariable = 42
        let myConstant = 42
        myVariable = 50
        
        let implicitInteger = 70
        let implicitDouble = 70.0
        let explicitDouble: Double = 70
        let imolicitFloat :Float = 4
        
        //值永远不会被隐式转换为其他类型。如果你需要把一个值转换成其他类型，请显式转换。
        let label = "The width is"
        let width = 94
        let widthLabel = label + String(width)
        
        let apples = 3
        let oranges = 5
        let appleSummary = "I have \(apples) apples."
        let fruitSummary = "I have \(apples + oranges) pieces of fruit."
        
        //数组
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        shoppingList[1] = "bottle of water"
        
        //字典
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
        ]
        occupations["Jayne"] = "Public Relations"
        
        //要创建一个空数组或者字典，使用初始化语法。
        let emptyArray = [String]()
        let emptyDictionary = [String: Float]()
        
        
        //类型后面加一个问号来标记这个变量的值是可选的
        let optionalName: String? = "John Appleseed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        
        //switch支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            let vegetableComment = "Add some raisins and make ants on a log."
        case "cucumber", "watercress":
            let vegetableComment = "That would make a good tea sandwich."
        case let sss where sss.hasSuffix("pepper"):
            let vegetableComment = "Is it a spicy \(sss)?"
        default:
            let vegetableComment = "Everything tastes good in soup."
        }
        
        //字典迭代
        
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        print(largest)
        
        //while 循环
        var n = 2
        while n < 100 {
            n = n * 2
        }
        print(n)
        
        var m = 2
        repeat {
            m = m*2
        }while m < 100
       
        print(m)
        
        // ..<
        var firstForLoop = 0
        for i in 0..<4 {
            firstForLoop += i
        }
        print(firstForLoop)
        
        var secondForLoop = 0
        for var i = 0; i < 4; ++i {
            secondForLoop += i
        }
        print(secondForLoop)
        
        //测试函数
        let statistics = calculateStatistics([5, 3, 100, 3, 9])
        print(statistics.sum)
        print(statistics.2)
        
        sumOf()
        sumOf(42, 597, 12)
        
    }
    
    //使用元组来让一个函数返回多个值。该元组的元素可以用名称或数字来表示。
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            sum += score
        }
        
        return (min, max, sum)
    }
    
    //函数可以带有可变个数的参数，这些参数在函数内表现为数组的形式：
    func sumOf(numbers: Int...) -> Int {
        var sum = 0
        for number in numbers {
            sum += number
        }
        return sum
    }
    
    //函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函数。
    func returnFifteen() -> Int {
        var y = 10
        func add() {
            y += 5
        }
        add()
        return y
    }
     
    //函数是第一等类型，这意味着函数可以作为另一个函数的返回值。
    func makeIncrementer() -> (Int -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        return addOne
    }
    
    //函数也可以当做参数传入另一个函数。
    func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
        for item in list {
            if condition(item) {
                return true
            }
        }
        return false
    }
    func lessThanTen(number: Int) -> Bool {
        return number < 10
    }
    
    //函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。
    //闭包中的代码能访问闭包所建作用域中能得到的变量和函数，即使闭包是在一个不同的作用域被执行的 - 
    //你已经在嵌套函数例子中所看到。你可以使用{}来创建一个匿名闭包。使用in将参数和返回值类型声明与闭包函数体进行分离。
    func functest(){
        let numbers =  [111,111,111,111]
        numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
        

    }
    
    
    
    
}


class Shape {
    var numberOfSides = 0
    let numberlet = 10
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    func stimpleDDD(dddd:String ) -> String{
        return "dafsdf"
        
    }
  
    var shape = Shape()
    
    
}

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    //如果你需要在删除对象之前进行一些清理工作，使用deinit创建一个析构函数。
    deinit{
        //清理工作，例如删除存储数据等操作
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//子类如果要重写父类的方法的话，需要用override标记——如果没有添加override就重写父类方法的话编译器会报错。编译器同样会检测override标记的方法是否确实在父类中。
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

//除了储存简单的属性之外，属性可以有 getter 和 setter 。
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
//    注意EquilateralTriangle类的构造器执行了三步：
//    按顺序执行
//    1 设置子类声明的属性值
//    2 调用父类的构造器
//    3 改变父类定义的属性值。其他的工作比如调用方法、getters和setters也可以在这个阶段完成。
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
}

//如果你不需要计算属性，但是仍然需要在设置一个新值之前或者之后运行代码，使用willSet和didSet。
class TriangleAndSquare {
    
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
    
    let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
    
    
    enum Rank: Int {
        case Ace = 1
        case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King
        func simpleDescription() -> String {
            switch self {
            case .Ace:
                return "ace"
            case .Jack:
                return "jack"
            case .Queen:
                return "queen"
            case .King:
                return "king"
            default:
                return String(self.rawValue)
            }
        }
    }
    
    enum Suit {
        case Spades, Hearts, Diamonds, Clubs
        func simpleDescription() -> String {
            switch self {
            case .Spades:
                return "spades"
            case .Hearts:
                return "hearts"
            case .Diamonds:
                return "diamonds"
            case .Clubs:
                return "clubs"
            }
        }
        
        func color() ->String{
            switch self{
            case .Spades,.Clubs:
                return "black"
            case .Hearts,.Diamonds:
                return  "red"
            }
        }
        
    }
    
    func testEnum(){
        let ace = Rank.Ace
        let aceRawValue = ace.rawValue
        
        if let convertedRank = Rank(rawValue: 3) {
            let threeDescription = convertedRank.simpleDescription()
        }
    }
    
    struct Card {
        var rank: Rank
        var suit: Suit
        func simpleDescription() -> String {
            return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
        }
    }
    func testEnum111(){
        enum ServerResponse {
            case Result(String, String)
            case Error(String)
        }
        
        let success = ServerResponse.Result("6:00 am", "8:09 pm")
        let failure = ServerResponse.Error("Out of cheese.")
        
        switch success {
        case let .Result(sunrise, sunset):
            let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
        case let .Error(error):
            let serverResponse = "Failure...  \(error)"
        }
        
    }
   
}

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
    
    func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]()
        for _ in 0..<numberOfTimes {
            result.append(item)
        }
        return result
    }
}

























