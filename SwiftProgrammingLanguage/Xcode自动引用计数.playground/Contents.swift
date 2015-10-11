//: Playground - noun: a place where people can play

import Cocoa

//使用自动引用计数（ARC）机制来跟踪和管理你的应用程序的内存。
//引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。
//为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例。

//为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢的保持住，只要强引用还在，实例是不允许被销毁的。

class Person1 {
    let name: String
    init(name: String) {
        self.name = name
        print("1111\(name) is being initialized")
    }
    deinit {
        print("1111\(name) is being deinitialized")
    }
}
//nil作为可选类型的初始化
var reference1: Person1?
var reference2: Person1?
var reference3: Person1?

//由于Person类的新实例被赋值给了reference1变量，所以reference1到Person类的新实例之间建立了一个强引用。
//正是因为这一个强引用，ARC 会保证Person实例被保持在内存中不被销毁。
reference1 = Person1(name: "John Appleseed1111")

// prints "John Appleseed is being initialized”

//如果你将同一个Person实例也赋值给其他两个变量，该实例又会多出两个强引用：
//同一个实例现在这一个Person实例已经有三个强引用了。
reference2 = reference1
reference3 = reference1

//如果你通过给其中两个变量赋值nil的方式断开两个强引用（包括最先的那个强引用），只留下一个强引用，Person实例不会被销毁：
reference1 = nil
reference2 = nil

//在你清楚地表明不再使用这个Person实例时，即第三个也就是最后一个强引用被断开时，ARC 会销毁它。
reference3 = nil
// prints "John Appleseed is being deinitialized"


//类实例之间的循环强引用
//我们可能会写出一个类实例的强引用数永远不能变成0的代码。如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。

//代码例子

//class Person {
//    let name: String
//    init(name: String) { self.name = name }
//    var apartment: Apartment?
//    deinit { print("\(name) is being deinitialized") }
//}
//
//class Apartment {
//    let unit: String
//    init(unit: String) { self.unit = unit }
//    var tenant: Person?
//    deinit { print("Apartment \(unit) is being deinitialized") }
//}
//
//var john: Person?
//var unit4A: Apartment?
//
//john = Person(name: "John Appleseed")
//unit4A = Apartment(unit: "4A")
//
////循环强引用
//john!.apartment = unit4A
//unit4A!.tenant = john
//
//
//john = nil //没有执行deinit
//unit4A = nil //没有执行deinit






//解决实例之间的循环强引用
//：弱引用（weak reference）和无主引用（unowned reference）。
//对于生命周期中会变为nil的实例使用弱引用。相反地，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。

//weak关键字表明这是一个弱引用。
//弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。

//代码例子
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("2222\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?  //弱引用
    deinit { print("2222Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil


//无主引用 unowned
//和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。

//由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。

//注意:
//如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。使用无主引用，你必须确保引用始终指向一个未销毁的实例。
//还需要注意的是如果你试图访问实例已经被销毁的无主引用，Swift 确保程序会直接崩溃，而不会发生无法预期的行为。所以你应当避免这样的事情发生。

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer //无主属性
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}


var john1: Customer?

john1 = Customer(name: "John Appleseed")
john1!.card = CreditCard(number: 1234_5678_9012_3456, customer: john1!)

john1 = nil //伴随着两个实例的销毁
// prints "John Appleseed is being deinitialized"
// prints "Card #1234567890123456 is being deinitialized"

//无主引用以及隐式解析可选属性

//1.Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。

//2.Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。

//3.存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。

//属性初始化完毕后，就能吧self作为对象传递给其他实例或者方法

class Country {
    let name: String
    var capitalCity: City!  //隐式解析可选属性
    init(name: String, capitalName: String) {
        self.name = name
        //只有Country的实例完全初始化完后，Country的构造函数才能把self传给City的构造函数。
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country //无主属性
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//以上的意义在于你可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值：
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// prints "Canada's capital city is called Ottawa"

//循环强引用的产生，是因为闭包和类相似，都是引用类型。
class HTMLElement {
    
    let name: String
    let text: String?
    
    //注意:
    //asHTML声明为lazy属性，因为只有当元素确实需要处理为HTML输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性。
    
    //注意:
//    虽然闭包多次使用了self，它只捕获HTMLElement实例的一个强引用。
    lazy var asHTML: Void -> String = {//可以理解为“一个没有参数，返回String的函数”
        [unowned self]()  in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// prints"hello, world"

//如果设置paragraph变量为nil，打破它持有的HTMLElement实例的强引用，HTMLElement实例和它的闭包都不会被销毁，也是因为循环强引用：
paragraph = nil

//解决闭包引起的循环强引用
//在定义闭包时同时定义捕获列表作为闭包的一部分，
//捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。

//注意:
//Swift 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod（而不只是someProperty或someMethod）。这提醒你可能会一不小心就捕获了self。

/*
捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（如self）或初始化过的变量（如delegate = self.delegate!）。这些项在方括号中用逗号分开。

lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
// closure body goes here
}

/如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字in放在闭包最开始的地方：

lazy var someClosure: Void -> String = {
    [unowned self, weak delegate = self.delegate!] in
// closure body goes here
}

*/

//弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。

//在闭包和捕获的实例总是互相引用时并且总是同时销毁时，将闭包内的捕获定义为无主引用。

//相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在。

//注意:
//如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用。

class HTMLElement1 {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in  //“用无主引用而不是强引用来捕获self”
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}



