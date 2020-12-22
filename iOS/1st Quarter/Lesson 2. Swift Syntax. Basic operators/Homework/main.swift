//
//  main.swift
//  Homework
//
//  Created by Aleksandr Saltykov on 19.12.2020.
//

import Foundation

//  Task 1
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

//  Task 2
func isDivisionByThree(number: Int) -> Bool {
    return number % 3 == 0
}

//  Task 3
var array = [Int](1...100)

//  Task 4
var index: Int = 0
for _ in array {
    if isEven(number: array[index]) || !(isDivisionByThree(number: array[index])){
        array.remove(at: index)
    } else {
        index = index + 1
    }
}
print("Array with odd and non-divisible by three numbers:\n\(array)")
print()

//  Task 5
func createFibonacciNumbers (count: Int) -> [Decimal] {
    var array: Array = [Decimal]()
    var n = 0
    while n < count {
        switch n {
            case 2...count - 1:
                array.append((array[n - 1] + array[n - 2]))
            default:
                array.append(Decimal(n))
        }
        n += 1
    }
    return array
}
let fibonacciNumbers: [Decimal] = createFibonacciNumbers(count: 100)
print("Fibonacci numbers of 100 elements:\n\(fibonacciNumbers)")
print()

//  Task 6
let primeNumbersCount = 100
var primeNumbers = [Int](0...primeNumbersCount - 1)
primeNumbers[1] = 0
var i = 2
while i <= primeNumbersCount  - 1 {
    if primeNumbers[i] != 0 {
        var j = i + i
        while j <= primeNumbersCount  - 1 {
            primeNumbers[j] = 0
            j += i
        }
    }
    i += 1
}
primeNumbers.removeAll{$0 == 0}
print("The result of the sieve of Eratosthenes:\n\(primeNumbers)")
print()
