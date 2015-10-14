//: Playground - noun: a place where people can play

import Cocoa

//访问控制可以限定其他源文件或模块中代码对你代码的访问级别。
//你可以明确地给单个类型（类、结构体、枚举）设置访问级别，也可以给这些类型的属性、函数、初始化方法、基本类型、下标索引等设置访问级别。协议也可以被限定在一定的范围内使用，包括协议里的全局常量、变量和函数。

//在Swift 中的一个模块可以使用import关键字引入另外一个模块。
//public
//internal：可以访问自己模块中源文件里的任何实体，但是别人不能访问该模块中源文件里的实体。通常情况下，某个接口或Framework作为内部结构使用时，你可以将其设置为internal级别。
//private：只能在当前源文件中使用的实体，称为私有实体。使用private级别，可以用作隐藏某些功能的实现细节。

//如果一个类 的扩展是定义在独立的源文件中，那么就不能访问这个类 的private成员。

//访问级别统一性
//一个public访问级别的变量，不能将它的类型定义为internal和private
//函数的访问级别不能高于它的参数、返回类型的访问级别。


//默认为internal级别

//这些被你定义为public的接口，就是这个Framework的API。
//注意：Framework的内部实现细节依然可以使用默认的internal级别，或者也可以定义为private级别。只有当你想把它作为 API 的一部分的时候，才将其定义为public级别。


//单元测试目标的访问级别
//果在引入一个生产模块时使用@testable注解，然后用带测试的方式编译这个生产模块，单元测试目标就可以访问所有internal级别的实体。


//元组的访问级别与元组中访问级别最低的类型一致。
//注意：元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推导出的，而不是明确的申明。

//函数返回类型的访问级别是private，所以你必须使用private修饰符

//枚举中成员的访问级别继承自该枚举，你不能为枚举中的成员单独申明不同的访问级别。

//枚举定义中的任何原始值或关联值的类型都必须有一个访问级别，这个级别至少要不低于枚举的访问级别。比如说，你不能在一个internal访问级别的枚举中定义private级别的原始值类型。

//子类的访问级别不得高于父类的访问级别。


//类A的访问级别是public，它包含一个函数someMethod，访问级别为private。类B继承类A，并且访问级别申明为internal，但是在类B中重写了类A中访问级别为private的方法someMethod，并重新申明为internal级别。通过这种方式，我们就可以访问到某类中private级别的类成员，并且可以重新申明其访问级别，以便其他人使用：

//因为父类A和子类B定义在同一个源文件中，所以在类B中可以在重写的someMethod方法中调用super.someMethod()。
public class A {
    private func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

//常量、变量、属性、下标
//常量、变量、属性不能拥有比它们的类型更高的访问级别
//如果常量、变量、属性、下标索引的定义类型是private级别的，那么它们必须要明确的申明访问级别为private
//在var或subscript定义作用域之前，你可以通过private(set)或internal(set)
//Setter的访问级别可以低于对应的Getter的访问级别

//注意：这个规定适用于用作存储的属性或用作计算的属性。即使你不明确地申明存储属性的Getter、Setter，Swift也会隐式的为其创建Getter和Setter，用于对该属性进行读取操作。使用private(set)和internal(set)可以改变Swift隐式创建的Setter的访问级别。这对计算属性也同样适用。
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits++  //记录value付了几次值
        }
        
        
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// prints "The number of edits is 3"



public struct TrackedString1 {
    public private(set) var numberOfEdits = 0 //Getter方法的访问级别设置为public Setter方法的访问级别设置为private：
    public var value: String = "" {
        didSet {
            numberOfEdits++
        }
    }
    public init() {}
}

//初始化
//但必要构造器例外，它的访问级别必须和所属类的访问级别相同。
//注意：如果一个类型被申明为public级别，那么默认的初始化方法的访问级别为internal。如果你想让无参的初始化方法在其他模块中可以被使用，那么你必须提供一个具有public访问级别的无参初始化方法。


//结构体的默认成员初始化方法
//如果结构体中的任一存储属性的访问级别为private，那么它的默认成员初始化方法访问级别就是private。尽管如此，结构体的初始化方法的访问级别依然是internal。

//协议中的每一个必须要实现的函数都具有和该协议相同的访问级别

//类可以采用比自身访问级别低的协议。
//采用了协议的类的访问级别取它本身和所采用协议中最低的访问级别
//注意：Swift和Objective-C一样，协议的一致性保证了一个类不可能在同一个程序中用不同的方法采用同一个协议。

//扩展成员应该具有和原始类成员一致的访问级别。

//如果一个扩展采用了某个协议，那么你就不能对该扩展使用访问级别修饰符来申明了。该扩展中实现协议的方法都会遵循该协议的访问级别。

//泛型类型或泛型函数的访问级别取泛型类型、函数本身、泛型类型参数三者中的最低访问级别。











