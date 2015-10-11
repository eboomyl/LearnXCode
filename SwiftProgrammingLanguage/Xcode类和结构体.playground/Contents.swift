//: Playground - noun: a place where people can play

import Cocoa


// 结构体和类的定义和实例化 类似java
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

someVideoMode.resolution.width = 1280

//结构体类型的成员逐一构造器(Memberwise Initializers for Structure Types)
//与结构体不同，类实例没有默认的成员逐一构造器。
let vga = Resolution(width:640, height: 480)

//结构体和枚举是值类型
//值类型被赋予给一个变量、常量或者本身被传递给一个函数的时候，实际上操作的是其的拷贝。

//在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且都是以结构体的形式在后台所实现。
//在 Swift 中，所有的结构体和枚举类型都是值类型。

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
//cinema的值其实是hd的一个拷贝副本，而不是hd本身。尽管hd和cinema有着相同的宽（width）和高（height）属性，但是在后台中，它们是两个完全不同的实例。
//枚举也遵守相同的准则
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}
// 输出 "The remembered direction is still .West"


//类是引用类型 
//与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，操作的是引用，其并不是拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
//需要注意的是tenEighty和alsoTenEighty被声明为常量（（constants）而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate,因为这两个常量本身不会改变。它们并不存储这个VideoMode实例，在后台仅仅是对VideoMode实例的引用。所以，改变的是被引用的基础VideoMode的frameRate参数，而不改变常量的值。

//恒等运算符
//因为类是引用类型，有可能有多个常量和变量在后台同时引用某一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）

//如果能够判定两个常量或者变量是否引用同一个类实例将会很有帮助。为了达到这个目的，Swift 内建了两个恒等运算符：

//等价于 （ === ）
//不等价于 （ !== ）

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}
//“等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
//“等于”表示两个实例的值“相等”或“相同”，判定时要遵照类设计者定义定义的评判标准，因此相比于“相等”，这是一种更加合适的叫法。


//指针

//类和结构体的选择
//然而，结构体实例总是通过值传递，类实例总是通过引用传递。这意味两者适用不同的任务。当你在考虑一个工程项目的数据构造和功能的时候，你需要决定每个数据构造是定义成类还是结构体。
//按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：

/*
1. 结构体的主要目的是用来封装少量相关简单数据值。
2. 有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
3. 任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
4. 结构体不需要去继承另一个已存在类型的属性或者行为。

举例：
几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
*/

//字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
//Swift 中字符串（String）,数组（Array）和字典（Dictionary）类型均以结构体的形式实现。值传递，拷贝

//Objective-C中字符串（NSString）,数组（NSArray）和字典（NSDictionary）类型均以类的形式实现，这与Swfit中以值传递方式是不同的。NSString，NSArray，NSDictionary在发生赋值或者传入函数（或方法）时，不会发生值拷贝，而是传递已存在实例的引用。







