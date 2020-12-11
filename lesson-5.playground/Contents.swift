import UIKit

enum Brands: String {
    case honda = "Honda"
    case toyota = "Toyota"
    case alfaRomeo = "Alfa Romeo"
    case mazda = "Mazda"
}

enum Transmission: String {
    case at = "АКПП"
    case mt = "МКПП"
}

enum EngineState {
    case on, off
}

enum OpenCloseState {
    case open, close
}


// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия
protocol Car {
    
    var brand: Brands { get }
    var model: String { get }
    var year: Int { get }
    var engineState: EngineState { get set }
    var windowsState: OpenCloseState { get set }
    
    mutating func turnEngine(state: EngineState)
    mutating func turnWindows(state: OpenCloseState)
}


// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
extension Car {
    
    mutating func turnEngine(state: EngineState) {
        self.engineState = state
        print("Двигатель в положение \(state)")
    }

    mutating func turnWindows(state: OpenCloseState) {
        self.windowsState = state
        print("Окна в положение \(state)")
    }
}


// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
class SportСar: Car {
    
    let brand: Brands
    let model: String
    let year: Int
    var engineState: EngineState = .off
    var windowsState: OpenCloseState = .close
    
    let maxSpeed: Int
    let transmission: Transmission
    var turbo: Bool = false

    init(brand: Brands, model: String, year: Int, maxSpeed: Int, transmission: Transmission) {

        self.brand = brand
        self.model = model
        self.year = year
        self.maxSpeed = maxSpeed
        self.transmission = transmission
    }
    
    func turboMode(state: Bool) {
        
        if self.turbo == state {
            print("Турбо уже " + (state ? "включено" : "выключено"))
        } else {
            self.turbo = state
            print((state ? "Включаем" : "Выключаем") + " турбо")
        }
        
        
    }
}


class TrunkCar: Car {
    
    let brand: Brands
    let model: String
    let year: Int
    var engineState: EngineState = .off
    var windowsState: OpenCloseState = .close
    
    let capacity: Int
    var capacityLoaded: Int
    var capacityFree: Int {
        get {
            return self.capacity - self.capacityLoaded
        }
    }

    init(brand: Brands,
         model: String,
         year: Int,
         capacity: Int,
         capacityLoaded: Int)
    {
        
        var _capacity = capacity
        var _loaded = capacityLoaded
        
        if _capacity < 0 {
            print("Указано некорректно значение грузоподъемности, оно будет установлено в 0")
            _capacity = 0
        }
        
        if _loaded > _capacity {
            print("Попытка загрузить больше, чем позволяет грузоподъемность. Будет установлено максимальное значение (\(_capacity))")
            _loaded = _capacity
        } else if _loaded < 0 {
            print("Нельзя установить отрицательное значение для загрузки. Будет устновлено значение 0")
            _loaded = 0
        }
        
        self.brand = brand
        self.model = model
        self.year = year
        self.capacity = _capacity
        self.capacityLoaded = _loaded
    }
    
    func loadTrunk(amount: Int) {
        
        if self.capacityFree >= amount {
            self.capacityLoaded += amount
            print("Загрузили \(amount) кг груза")
        } else {
            print("\(amount) кг не влезет. У нас осталось свободного места всего для \(self.capacityFree) кг груза")
        }
    }
    
    func unloadTrunk(amount: Int) {
        
        if self.capacityLoaded < amount {
            self.capacityLoaded = 0
            print("Вы пытаетесь разгрузить \(amount) кг, а у нас всего \(self.capacityLoaded) кг. Выгрузили всё, что смогли")
        } else {
            self.capacityLoaded -= amount
            print("Выгрузили \(amount) кг груза")
        }
    }
}


// 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension SportСar: CustomStringConvertible {
    
    var description: String {
        return String(describing: "Спортивный автомобиль \(self.brand.rawValue) \(self.model) (\(self.year) г.в., \(self.transmission.rawValue)) имеет максимальную скорость \(self.maxSpeed) км/ч. Турборежим сейчас " + (self.turbo ? "включен" : "выключен"))
    }
}

extension TrunkCar: CustomStringConvertible {
    
    var description: String {
        return String(describing: "Грузовой автомобиль \(self.brand.rawValue) \(self.model) (\(self.year) г.в.) имеет грузоподъемность \(self.capacity) кг. Сейчас загружено \(self.capacityLoaded) кг")
    }
}


// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
var car1 = SportСar(brand: .toyota, model: "Celica", year: 1997, maxSpeed: 220, transmission: .mt)
car1.turnEngine(state: .on)
car1.turnWindows(state: .open)
car1.turboMode(state: true)

var car2 = SportСar(brand: .honda, model: "Civic X", year: 2019, maxSpeed: 240, transmission: .at)
car2.turnEngine(state: .on)
car2.turboMode(state: true)

var car3 = TrunkCar(brand: .toyota, model: "ToyoAce", year: 1990, capacity: 1500, capacityLoaded: 0)
car3.loadTrunk(amount: 500)
car3.turnEngine(state: .on)

var car4 = TrunkCar(brand: .mazda, model: "Bongo", year: 2010, capacity: 1000, capacityLoaded: 250)
car4.unloadTrunk(amount: 250)
car4.loadTrunk(amount: 1000)
car4.turnEngine(state: .on)


// 6. Вывести сами объекты в консоль.
var cars: [Car] = [car1, car2, car3, car4]

for car in cars {
    print(car)
}
