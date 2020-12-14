//
//  main.swift
//  Homework
//
//  Created by Aleksandr Saltykov on 14.12.2020.
//

import Foundation

//  Task 1: Quadratic equation

let x = 5
let y = x * x
print("Task 1")
print("Quadratic equation:", x, " *", x, "  = ", y)
print()

//  Task 2: Area, perimeter and hypotenuse of a triangle
let a: Double = 3.2
let b: Double = 4
let c: Double = (a * a + b * b).squareRoot()
let S = ( a * b ) / 2
let P = a + b + c
print("Task 2")
print("Legs of a right triangle: a =", a, "and b =", b)
print("Hypotenuse of a right triangle: c = ", c)
print("Area of a right triangle: S = ", S)
print("Perimeter of a right triangle: P = ", P)
print()

//  Task 3: Deposit amount
let years: Int = 5
let rate: Double = 4.5
var depositAmount: Double = 1000000
print("Task 3")
for year in 1...years {
    depositAmount = depositAmount + (depositAmount * (rate / 100))
    print("Deposit amount after", year,"year:", round(depositAmount * 100) / 100)
}
print()
