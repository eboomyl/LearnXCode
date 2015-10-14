//: Playground - noun: a place where people can play

import Cocoa

func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//注意 请始终使用大写字母开头的驼峰式命名法（例如T和Key）来给类型参数命名，以表明它们是类型的占位符，而非类型值。



//泛型栈

struct Stack1<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

//扩展一个泛型类型
extension Stack1  {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

//类型约束
//类型约束指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成。
//在字典的描述中，字典的键类型必须是可哈希，也就是说，必须有一种方法可以使其被唯一的表示。
//类型约束语法
//
//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    // 这里是函数主体
//}

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//关联类型(Associated Types)
//关联类型被指定为typealias关键字。

protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    // IntStack的原始实现
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // 遵循Container协议的实现
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}

//扩展一个存在的类型为一指定关联类型
//Array已经提供append(_:)方法，一个count属性和通过下标来查找一个自己的元素。这三个功能都达到Container协议的要求。也就意味着你可以扩展Array去遵循Container协议，只要通过简单声明Array适用于该协议而已。如何实践这样一个空扩展，在通过扩展补充协议声明中有描述这样一个实现一个空扩展的行为：
extension Array: Container {}

//你可以将任何Array当作Container来使用。


//Where 语句

func allItemsMatch<
    C1: Container, C2: Container      //C1必须遵循Container协议 (写作 C1: Container)。C2必须遵循Container协议 (写作 C2: Container)。
    where C1.ItemType == C2.ItemType, //C1的ItemType同样是C2的ItemType（写作 C1.ItemType == C2.ItemType）。
    C1.ItemType: Equatable>           //C1的ItemType必须遵循Equatable协议 (写作 C1.ItemType: Equatable)。
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
        
        // 检查两个Container的元素个数是否相同
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // 检查两个Container相应位置的元素彼此是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // 如果所有元素检查都相同则返回true
        return true
        
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings,  arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// 输出 "All items match."
















