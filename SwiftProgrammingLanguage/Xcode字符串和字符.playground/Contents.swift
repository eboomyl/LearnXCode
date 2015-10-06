//: Playground - noun: a place where people can play

import Cocoa

//使用字符
for character in "Dog!🐶".characters {
    print(character)
}

//append()方法将一个字符附加到一个字符串变量的尾部：

//字符串插值 \(value)
//插值字符串中写在括号中的表达式不能包含非转义双引号 (") 和反斜杠 (\)，并且不能包含回车或换行符。


/*  Unicode 标量（Unicode Scalars）
 Unicode 标量是对应字符或者修饰符的唯一的21位数字

注意： Unicode 码位(code poing) 的范围是U+0000到U+D7FF或者U+E000到U+10FFFF。Unicode 标量不包括 Unicode 代理项(surrogate pair) 码位，其码位范围是U+D800到U+DFFF。
*/


/*

字符串字面量可以包含以下特殊字符：
转义字符\0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
Unicode 标量，写成\u{n}(u为小写)，其中n为任意一到八位十六进制数且可用的 Unicode 位码。
*/

/*
可扩展的字形群集(Extended Grapheme Clusters)

e(U+0065) 加上一个急促重音的标量(U+0301)
这样一对标量就表示了同样的字母é。 这个急促重音的标量形象的将e转换成了é。

*/
var ele = "\u{0065}\u{0301}"
ele.characters.count

//可拓展的字符群集可以使包围记号(例如COMBINING ENCLOSING CIRCLE或者U+20DD)的标量包围其他 Unicode 标量，作为一个单一的Character值：
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 是 é⃝


let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS 是

//字符的数量  
//characters属性的count属性：
var word = "cafe"
word.characters.count

//另外需要注意的是通过characters属性返回的字符数量并不总是与包含相同字符的NSString的length属性相同。NSString的length属性是利用 UTF-16 
//表示的十六位代码单元数字，而不是 Unicode 可扩展的字符群集。作为佐证，当一个NSString的length属性被一个Swift的String值访问时，实际上是调用了utf16Count。

//字符串索引 (String Indices)
//String.Index  它对应着字符串中的每一个Character的位置。
let greeting = "Guten Tag!"
greeting.startIndex
greeting[greeting.startIndex]
// G
greeting.endIndex.predecessor()
greeting[greeting.endIndex.predecessor()]
// !
greeting.startIndex.successor()
greeting[greeting.startIndex.successor()]
// u
let index = greeting.startIndex.advancedBy(7)
greeting[index]
// a


for index in greeting.characters.indices {
    print("\(greeting[index]) ", terminator: " ")
}

//插入和删除 (Inserting and Removing)
//调用insert(_:atIndex:)方法可以在一个字符串的指定索引插入一个字符。

var welcome = "hello"
welcome.insert("!", atIndex: welcome.endIndex)

welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())

welcome.removeAtIndex(welcome.endIndex.predecessor())

let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)

//比较字符串 (Comparing Strings)


// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}

//相反，英语中的LATIN CAPITAL LETTER A(U+0041，或者A)不等于俄语中的CYRILLIC CAPITAL LETTER A(U+0410，或者A)。两个字符看着是一样的，但却有不同的语言意义：

let latinCapitalLetterA: Character = "\u{41}"

let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}

//前缀/后缀相等 (Prefix and Suffix Equality)

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        ++act1SceneCount
    }
}

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        ++mansionCount
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        ++cellCount
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// 打印输出 "6 mansion scenes; 2 cell scenes"



//字符串的 Unicode 表示形式（Unicode Representations of Strings）

let dogString = "Dog‼🐶"

for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}

print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}




