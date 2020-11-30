import UIKit
import Foundation

// 1. Написать функцию, которая определяет, четное число или нет.

func isEven(number: Int) -> Bool {
    return number % 2 == 0 ? true : false
}



// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func checkDivisionOnThree(number: Int) -> Bool {
    return number % 3 == 0 ? true : false
}



// 3. Создать возрастающий массив из 100 чисел.

var someArray = [Int](1...100)


// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for value in someArray {
    if isEven(number: value) || !checkDivisionOnThree(number: value) {
        someArray.remove(at: someArray.firstIndex(of: value)!)
    }
}



// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.


// Вариант 1 – строго по заданию
func addFibonacciNumber(arr: inout [Decimal]) {

    let arraySize = arr.count

    switch arraySize {
    case 0:
        arr.append(0)
    case 1...2:
        arr.append(1)
    default:
        let newNumber = arr[arraySize-1] + arr[arraySize-2]
        arr.append(newNumber)
    }
}

var fibArr = [Decimal]()

for _ in 1...100 {
    addFibonacciNumber(arr: &fibArr)
}


// Вариант 2 – просто задаем, сколько надо чисел и возвращаем нужное количество чисел. Как мне кажется это менее ресурсозатратный вариант, т.к. не измеряет объём массива в цикле for
func getFibonacciNumbers(total count: Int) -> [Decimal] {
    
    var result = [Decimal]()
    
    guard count > 0 else { return result }
    
    for i in 0..<count {
        if i == 0 {
            result.append(0)
        } else if i < 3 {
            result.append(1)
        } else {
            result.append(result[i-1] + result[i-2])
        }
    }
    
    return result
}

let customArr = getFibonacciNumbers(total: 100)
print(customArr)



// 6. * Заполнить массив из 100 элементов различными простыми числами.

// Проверка на простое число
func isPrime(number: Int) -> Bool {
    
    var n = 2;
    
    // Любое составное число имеет делитель, квадрат которого не превосходит делимое – ставим эту проверку, чтобы уменьшить количество итераций при работе с большими числами и, тем самым, упростим сложность алгоритма
    while n*n <= number && number % n != 0 {
        n += 1
    }
    
    return n * n > number
}

var primeNumbers = [Int]()
var checkNumber = 2

while primeNumbers.count < 100 {
    if isPrime(number: checkNumber) {
        primeNumbers.append(checkNumber)
    }
    checkNumber += 1
}

print( primeNumbers )
