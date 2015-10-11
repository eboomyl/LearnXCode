//: Playground - noun: a place where people can play

import Cocoa

// 使用self 使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// 打印输出: This point is to the right of the line where x == 1.0


//你确实需要在某个具体的方法中修改结构体或者枚举的属性，你可以选择变异(mutating)这个方法，然后方法就可以从方法内部改变它的属性；并且它做的任何改变在方法结束时还会保留在原始结构中。方法还可以给它隐含的self属性赋值一个全新的实例，这个新实例在方法结束后将替换原来的实例。

//方法定义时加上mutating关键字，这才让方法可以修改值类型的属性
struct Point1 {
    var x = 0.0, y = 0.0//修改该属性的值的方法必须加上mutating
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePoint1.x), \(somePoint1.y))")
// 打印输出: "The point is now at (3.0, 4.0)"
//注意：结构体被声明为let的话，即使增加mutating也不能修改属性的值


//变异方法能够赋给隐含属性self一个全新的实例。上面Point的例子可以用下面的方式改写：
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}


enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于 .High
ovenLight.next()
// ovenLight 现在等于 .Off



//类型方法 (Type Methods)
//在类型方法的方法体（body）中，self指向这个类型本身，而不是类型的某个实例。对于结构体和枚举来说，这意味着你可以用self来消除静态属性和静态方法参数之间的歧义（类似于我们在前面处理实例属性和实例方法参数时做的那样）。
struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}


var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// 打印输出：highest unlocked level is now 2

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// 打印输出：level 6 has not yet been unlocked



