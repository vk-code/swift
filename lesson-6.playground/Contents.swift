import UIKit

// Подготовка
enum CarTypes: String {
    
    case trunk = "Грузовик"
    case sport = "Спортивная тачка"
}

protocol Vehicle {
    
    var type: CarTypes { get }
    var horsePower: Int { get }
}

struct Car: Vehicle, CustomStringConvertible {

    let name: String
    let type: CarTypes
    let horsePower: Int
    var description: String {
        return "\(type.rawValue) \(name) мощностью \(horsePower) л.с."
    }
}


// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
struct Queue<T: Vehicle> {
    
    private var _elements: [T] = []
    
    mutating func push(_ element: T) {
        _elements.append(element)
    }
    
    mutating func ​​pop​() -> T? {
        return _elements.removeLast()
    }
    
    // 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
    private func filter(predicate: (T) -> Bool) -> [T] {
        var result: [T] = []
        
        for item in _elements {
            if predicate(item) {
                result.append(item)
            }
        }
        
        return result
    }
    
    func getByType(_ type: CarTypes) -> [T] {
        return filter { element in
            return element.type == type
        }
    }

    func getByPower(_ power: Int) -> [T] {
        return filter { $0.horsePower >= power }
    }
    

    // 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
    subscript(_ index: Int) -> T? {
        guard !_elements.isEmpty && index < _elements.count else { return nil }
        return _elements[index]
    }
}


// Тест
var cars = Queue<Car>()

cars.push(Car(name: "Honda", type: .sport, horsePower: 300))
cars.push(Car(name: "Toyota", type: .sport, horsePower: 350))
cars.push(Car(name: "MAN", type: .trunk, horsePower: 600))
cars.push(Car(name: "Volvo", type: .trunk, horsePower: 550))
cars.push(Car(name: "Lamborgini", type: .sport, horsePower: 900))

let trunks = cars.getByType(.trunk)
let sports = cars.getByType(.sport)
let muscleCars = cars.getByPower(500)

cars[0]
cars[70]
