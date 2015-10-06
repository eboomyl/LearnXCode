//: Playground - noun: a place where people can play

import Cocoa

//你可以在一行中定义多个同样类型的变量，用逗号分割，并在最后一个变量名之后添加类型标注：
var red, green, blue: Double

/* 这是第一个多行注释的开头
/* 这是第二个被嵌套的多行注释 */
*/

//有一种情况下必须要用分号，即你打算在同一行内写多条独立的语句
let cat = "🐱"; print(cat)

//整数范围
let minValue = UInt8.min  // minValue 为 0，是 UInt8 类型
let maxValue = UInt8.max  // maxValue 为 255，是 UInt8 类型
let intMax = Int.max
let intMin = Int.min


/*
一个十进制数，没有前缀
一个二进制数，前缀是0b
一个八进制数，前缀是0o
一个十六进制数，前缀是0x
*/

let decimalInteger = 17            //10进制的17
let binaryInteger = 0b10001       // 二进制的17
let octalInteger = 0o21           // 八进制的17
let hexadecimalInteger = 0x11     // 十六进制的17


let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

//整数和浮点数的转换必须显式指定类型：
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine


//类型别名
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min


//元组（tuples）把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型。
let http404Error = (404, "Not Found")

//你可以将一个元组的内容分解（decompose）成单独的常量和变量，然后你就可以正常使用它们了：
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

//如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记：
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

//此外，你还可以通过下标来访问元组中的单个元素，下标从零开始：
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

//你可以在定义元组的时候给单个元素命名：
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

//使用可选类型（optionals）来处理值可能缺失的情况。可选类型表示：有值或者nil
//这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。对于这些类型，Objective-C 方法一般会返回一个特殊值（比如NSNotFound）来暗示值缺失。
//一个可选类型用类型加问号显示例如 Int？ 也就是说可能包含Int值也可能不包含值。

var serverResponseCode: Int? = 404
// serverResponseCode 包含一个可选的 Int 值 404
serverResponseCode = nil  //Swift 中，nil不是指针——它是一个确定的值，用来表示值缺失。
// serverResponseCode 现在不包含值

//nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"

//!强制解析（forced unwrapping）可选类型的值
//使用!来获取一个不存在的可选值会导致运行时错误。使用!来强制解析值之前，一定要确定可选包含一个非nil的值。

//你可以包含多个可选绑定在if语句中，并使用where子句做布尔值判断。
if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}
// prints "4 < 42"



let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要惊叹号来获取值

//隐式解析
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号

//错误处理
func canThrowAnError() throws {
    // 这个函数有可能抛出错误
}

do {
    try canThrowAnError()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}


//断言
let age = 3
assert(age >= 0, "A person's age cannot be less than zero")






