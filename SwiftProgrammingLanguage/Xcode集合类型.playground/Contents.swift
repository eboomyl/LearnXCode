//: Playground - noun: a place where people can play

import Cocoa

//Swift 语言提供Arrays、Sets和Dictionaries三种基本的集合类型用来存储集合数据。数组是有序数据的集。集合是无序无重复数据的集。字典是无序的键值对的集。

var someInts = [Int]()
someInts.append(3)
// someInts 现在包含一个 Int 值
someInts = []
// someInts 现在是空数组，但是仍然是 [Int] 类型的。

var threeDoubles = [Double](count: 3, repeatedValue:0.0)
// threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]

var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)
// anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

var threeInts  = [Int](count: 3, repeatedValue: 1)

var tenString  = [String](count: 10, repeatedValue: "test")

class Test {
    init(){
        
    }
    func testTT(){
        
    }
}

var fiveTest = [Test](count: 5, repeatedValue: Test())

var shoppingList: [String] = ["Eggs", "Milk"]

var shoppingList2 = ["Eggs", "Milk"]

//访问和修改数组
shoppingList.count

//使用布尔值属性isEmpty作为检查count属性的值是否为 0 的捷径：
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}


//也可以使用append(_:)方法在数组后面添加新的数据项：

shoppingList.append("Flour")

shoppingList += ["Baking Powder"]
// shoppingList 现在有四项了
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList 现在有七项了

var firstItem = shoppingList[0]
// 第一项是 "Eggs"

//去掉一项
shoppingList[4...6] = ["Bananas", "Apples"]

shoppingList.insert("Maple Syrup", atIndex: 0)
// shoppingList 现在有7项
// "Maple Syrup" 现在是这个列表中的第一项

let mapleSyrup = shoppingList.removeAtIndex(0)
// 索引值为0的数据项被移除
// shoppingList 现在只有6项，而且不包括 Maple Syrup
// mapleSyrup 常量的值等于被移除数据项的值 "Maple Syrup"

let apples = shoppingList.removeLast()
// 数组的最后一项被移除了
// shoppingList 现在只有5项，不包括 cheese
// apples 常量的值现在等于 "Apples" 字符串


//enumerate()返回一个由每一个数据项索引值和数据值组成的元组。
for (index, value) in shoppingList.enumerate() {
    print("Item \(String(index + 1)): \(value)")
}


//集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。
//Set类型被写为Set<Element>，这里的Element表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式。
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// 打印 "letters is of type Set<Character> with 0 items."

letters.insert("a")
// letters 现在含有1个 Character 类型的值
letters = []
// letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop","hello","hi"]

//两个集合相交
favoriteGenres.intersect(favoriteGenres2)


//两个集合除了相交部分
favoriteGenres.exclusiveOr(favoriteGenres2)

//两个集合全部 不重复
favoriteGenres.union(favoriteGenres2)

//a集合中不包含b集合的部分
favoriteGenres.subtract(favoriteGenres2)
favoriteGenres2.subtract(favoriteGenres)


//你可以通过调用Set的remove(_:)方法去删除一个元素，如果该值是该Set的一个元素则删除该元素并且返回被删除的元素值，否则如果该Set不包含该值，则返回nil。另外，Set中的所有元素可以通过它的removeAll()方法删除。
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

//使用contains(_:)方法去检查Set中是否包含一个特定的值：
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// 打印 "It's too funky in here."

//Swift 的Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sort()方法，它将根据提供的序列返回一个有序集合.
for genre in favoriteGenres.sort() {
    print("\(genre)")
}


//集合操作

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sort()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersect(evenDigits).sort()
// []
oddDigits.subtract(singleDigitPrimeNumbers).sort()
// [1, 9]
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()
// [1, 2, 9]


//使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
//使用isSubsetOf(_:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
//使用isSupersetOf(_:)方法来判断一个集合中包含另一个集合中所有的值。
//使用isStrictSubsetOf(_:)或者isStrictSupersetOf(_:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
//使用isDisjointWith(_:)方法来判断两个集合是否不含有相同的值。

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubsetOf(farmAnimals)
// true
farmAnimals.isSupersetOf(houseAnimals)
// true
farmAnimals.isDisjointWith(cityAnimals)
// true


//字典
//字典中的数据项并没有具体顺序。
//一个字典的Key类型必须遵循Hashable协议，就像Set的值类型。
var namesOfIntegers = [Int: String]()
// namesOfIntegers 是一个空的 [Int: String] 字典

var namesOfIntegers2 = [:]


//用字典字面量创建字典
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

airports["LHR"] = "London"
// airports 字典现在有三个数据项

airports["LHR"] = "London Heathrow"
// "LHR"对应的值 被改为 "London Heathrow

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// 输出 "The old value for DUB was Dublin."

//字典的下标访问会返回对应值的类型的可选值。
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}


airports["APL"] = "Apple Internation"
// "Apple Internation" 不是真的 APL 机场, 删除它
airports["APL"] = nil
// APL 现在被移除了


if let removedValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// prints "The removed airport's name is Dublin Airport."

//字典遍历
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// YYZ: Toronto Pearson
// LHR: London Heathrow

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: YYZ
// Airport code: LHR

for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: Toronto Pearson
// Airport name: London Heathrow

let airportCodes = [String](airports.keys)
// airportCodes 是 ["YYZ", "LHR"]

let airportNames = [String](airports.values)
// airportNames 是 ["Toronto Pearson", "London Heathrow"]
// Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的keys或values属性使用sort()方法。



















