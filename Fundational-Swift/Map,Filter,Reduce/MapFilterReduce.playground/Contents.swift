//: Playground - noun: a place where people can play

import UIKit

// 每项+1
func incrementArray(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x + 1)
    }
    return result
}
incrementArray(xs: Array(repeating: 1, count: 5))

// 每项*2
func doubleArray1(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x * 2)
    }
    return result
}
doubleArray1(xs: Array(repeating: 1, count: 5))


// 无论每项 +1 | *2 ，两个函数定义的时候都有大量相同的代码， 提取有区别的地方，并抽象出来
func computeIntArray(xs: [Int], transform: (Int) -> Int) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func doubleArray2(xs: [Int]) -> [Int] {
    return computeIntArray(xs: xs, transform: {x in x*2})
}

func increamentArray2(xs: [Int]) -> [Int] {
    return computeIntArray(xs: xs, transform: {x in x+1})
}

increamentArray2(xs: Array(repeating: 1, count: 5))
doubleArray2(xs: Array(repeating: 1, count: 5))

// 然而代码任然不像想象中那么灵活。 假设我们像得到一个Bool的新数组，表示原数组中对应的数字是否为偶数
//func isEvenArray(xs: [Int]) -> [Bool] {
//    return computeIntArray(xs: xs) { x in x%2 == 0}
//}
