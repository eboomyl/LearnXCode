//: Playground - noun: a place where people can play

import Cocoa

//可空链式调用（Optional Chaining）

class Person {
    var residence: Residence?
}
//
//class Residence {
//    var numberOfRooms = 1
//}
//
//
//let john = Person()
//
////let roomCount = john.residence!.numberOfRooms
//// this triggers a runtime error
//
//if let roomCount = john.residence?.numberOfRooms {//可空链式调用
//    print("John's residence has \(roomCount) room(s).")
//} else {
//    print("Unable to retrieve the number of rooms.")
//}
//// prints "Unable to retrieve the number of rooms."




class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// prints "Unable to retrieve the number of rooms."



if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// prints "Unable to retrieve the first room name."

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress


//这个方法的返回类型为Void?，而不是Void
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// prints "It was not possible to print the number of rooms."


//若赋值成功则返回Void类型
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// prints "It was not possible to set the address."

//通过下标访问？在方括号前面
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// prints "Unable to retrieve the first room name."

john.residence?[0] = Room(name: "Bathroom")


let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// prints "The first room name is Living Room."



//访问可空类型的下标：
//如果下标返回可空类型值，比如Swift中Dictionary的key下标。可以在下标的闭合括号后面放一个问号来链接下标的可空返回值：
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]

//多层链接
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// prints "Unable to retrieve the address."

//多层链接
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// prints "John's street name is Laurel Street."

//对返回可空值的函数进行链接
//上面的例子说明了如何通过可空链式调用来获取可空属性值。我们还可以通过可空链式调用来调用返回可空值的方法，并且可以继续对可空值进行链接。
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// prints "John's building identifier is The Larches."

if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
}
// prints "John's building identifier begins with "The"."
//注意： 在上面的例子中在，在方法的圆括号后面加上问号是因为buildingIdentifier()的返回值是可空值，而不是方法本身是可空的。
















