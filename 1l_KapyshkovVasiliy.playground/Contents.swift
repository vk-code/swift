import UIKit


// 1. Решить квадратное уравнение
func quadratic(a: Double, b: Double, c: Double) -> String {
    
    let d: Double = pow(b, 2) - 4 * a * c
    
    if( d < 0 ) {
        
        return "Уравнение не имеет квадратных корней"
        
    } else if(d == 0) {
        
        let x = -b / 2 * a
        return "Уравнение имеет один квадратный корень: x = \(x)"
        
    } else {
        
        let x1 = (-b + sqrt(d)) / (2 * a)
        let x2 = (-b - sqrt(d)) / (2 * a)
        
        return "Уравнение имеет два корня: \(x1) и \(x2)"
    }
}

let result = quadratic(a: 3, b: -14, c: -5)
print(result)





// 2. Найти площадь, периметр и гипотенузу треугольника
let c1: Double = 3
let c2: Double = 4

// Гипотенуза
let g = sqrt(c1*c1 + c2*c2)
print("Гипотенуза треугольника = \(g)")

// Периметр
let perimeter = c1 + c2 + g
print("Периметр треугольника = \(perimeter)")

// Площадь
let square = c1 * c2 / 2
print("Площадь треугольника = \(square)")





// 3. Найти сумму вклада через 5 лет
var summ: Double = 300000.87
let percent: Double = 20

for _ in 1...5 {
    summ += summ * (percent / 100)
}

let formattedSumm = String(format: "%.2f", summ)
print("Сумма вклада через 5 лет: \(formattedSumm) ₽")
