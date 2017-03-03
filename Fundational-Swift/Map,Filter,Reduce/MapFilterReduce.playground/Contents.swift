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

// 由于扩展性不佳， 我们使用范型。
// computeBoolArray和computeIntArray的定义是相同的，唯一的区别在于类型签名（type signature）。
func genericComputeArray1<T>(xs: [Int], transform: (Int) -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func genericComputeArray<T>(xs: [Int], transform: (Int) -> T) -> [T] {
    return xs.map(transform)
}

let result = genericComputeArray(xs: Array(repeating: 1, count: 5), transform: {x in x+1})
print(result)


struct City {
    let name: String
    let population: Int
}
let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)

let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}

[1,2,3].reduce(1, *)
let display = cities.filter{$0.population > 1000}
    .map{$0.cityByScalingPopulation()}
    .reduce("Citi: Population"){ result, c in
        return result + "\n" + "\(c.name): \(c.population)"
}

print(display)
