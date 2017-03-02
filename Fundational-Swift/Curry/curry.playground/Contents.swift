//: Playground - noun: a place where people can play

import UIKit

// 常见风格
func add1(x: Int, _ y: Int) -> Int {
    return x+y
}

// CURRY风格
func add2(x: Int) -> ((Int)->Int) {
    return { y in return x+y }
}

add1(x: 1, 2)

add2(x: 1)(2)
