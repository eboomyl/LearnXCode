//: Playground - noun: a place where people can play

import Cocoa
//下标脚本 可以定义在类（Class）、结构体（structure）和枚举（enumeration）这些目标中，
//newValue的类型必须和下标脚本定义的返回类型相同。与计算型属性相同的是set的入参声明newValue就算不写，在set代码块中依然可以使用默认的newValue这个变量来访问新赋的值。

/*语法

 subscript(index: Int) -> Int {
    get {
        // 返回与入参匹配的Int类型的值
    }
    
    set(newValue) {
        // 执行赋值操作
    }
}


//与只读计算型属性一样，可以直接将原本应该写在get代码块中的代码写在subscript中：

subscript(index: Int) -> Int {
// 返回与入参匹配的Int类型的值
}
*/

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是\(threeTimesTable[6])")//下标脚本的使用方法
// 输出 "3的6倍是18"


//如下例定义了一个Matrix结构体，将呈现一个Double类型的二维矩阵。Matrix结构体的下标脚本需要两个整型参数：
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]  //grid是矩阵二维数组的扁平化存储：
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)//将Matrix中每个元素初始值0.0
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2