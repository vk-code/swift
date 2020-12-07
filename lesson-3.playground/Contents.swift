import UIKit

enum Brands: String {
    case honda = "Honda"
    case toyota = "Toyota"
    case nissan = "Nissan"
    case alfaRomeo = "Alfa Romeo"
    case acura = "Acura"
    case mazda = "Mazda"
}

enum EngineState {
    case on, off
}

enum WindowsState {
    case open, close
}

enum CarActions {
    case turnEngine(state: EngineState)
    case setWindows(state: WindowsState)
    case loadIntoTrunk(amount: Float)
    case unloadFromTrunk(amount: Float)
}

struct SportCar {
    
    let brand: Brands
    let year: Int
    let doors: Int
    var engineState: EngineState
    var windowsState: WindowsState
    
    mutating func change(action: CarActions) {
        switch action {
        case let .turnEngine(state):
            self.engineState = state
            
        case let .setWindows(state):
            self.windowsState = state
            
        default:
            print("В спортивной машине нельзя перевозить груз!")
            return
        }
    }
}


struct TrunkCar {
    
    let brand: Brands
    let year: Int
    let trunkCapacity: Float
    var trunkCapacityFilled: Float
    var engineState: EngineState
    var windowsState: WindowsState
    var trunkLeft: Float {
        get {
            return self.trunkCapacity - self.trunkCapacityFilled
        }
    }
    
    init(brand: Brands, year: Int, capacity: Float, filled: Float, engine: EngineState, windows: WindowsState) {
        
        var _capacity = capacity
        var _filled = filled
        
        if _capacity < 0 {
            print("Грузоподъемность не может быть отрицательной. Будет устанавлено значение 0")
            _capacity = 0
        }
        
        if _filled < 0 {
            print("Загружаемое количество не может быть отрицательным числом. Значение будет установлено равным нулю")
            _filled = 0
        } else if _filled > _capacity {
            print("Загружаемое количество не может быть больше объема багажника. Будет установлено максимально возможное значение")
            _filled = _capacity
        }
        
        self.brand = brand
        self.year = year
        self.trunkCapacity = _capacity
        self.trunkCapacityFilled = _filled
        self.engineState = engine
        self.windowsState = windows
    }
    
    mutating func change(action: CarActions) {
        switch action {
        case let .turnEngine(state):
            self.engineState = state
            
        case let .setWindows(state):
            self.windowsState = state
            
        case let .loadIntoTrunk(amount):
            if self.trunkLeft >= amount {
                self.trunkCapacityFilled += amount
            } else {
                print("\(amount) кг не влезет. У нас осталось свободного места всего для \(self.trunkLeft) кг груза")
            }
            
        case let .unloadFromTrunk(amount):
            if self.trunkCapacityFilled < amount {
                print("Вы пытаетесь разгрузить \(amount) кг, а у нас всего \(self.trunkCapacityFilled) кг. Выгрузили всё, что смогли")
                self.trunkCapacityFilled = 0
            } else {
                self.trunkCapacityFilled -= amount
            }
        }
    }
}


var civic = SportCar(brand: .honda, year: 2003, doors: 3, engineState: .off, windowsState: .close)

print(civic.brand.rawValue)
civic.change(action: .turnEngine(state: .on))
print("Статус двигателя:", civic.engineState)
civic.change(action: .setWindows(state: .open))
print("Положение окон:", civic.windowsState)


var julia = SportCar(brand: .alfaRomeo, year: 2015, doors: 2, engineState: .off, windowsState: .open)

print(julia.brand.rawValue)
julia.change(action: .turnEngine(state: .on))
print("Статус двигателя:", julia.engineState)
julia.change(action: .setWindows(state: .close))
print("Положение окон:", julia.windowsState)


var bongo = TrunkCar(brand: .mazda, year: 1998, capacity: 1000, filled: 0, engine: .off, windows: .close)

bongo.change(action: .loadIntoTrunk(amount: 980))
print("В машину загружено \(bongo.trunkCapacityFilled) кг груза. Можно загрузить ещё \(bongo.trunkLeft) кг")
bongo.change(action: .loadIntoTrunk(amount: 330))
bongo.change(action: .unloadFromTrunk(amount: 500))
bongo.change(action: .turnEngine(state: .on))
bongo.change(action: .setWindows(state: .open))
print("Статус авто \(bongo.brand.rawValue) (\(bongo.year) г.в.): Окна в положении \(bongo.windowsState), двигатель в положении \(bongo.engineState), объём груза на борту \(bongo.trunkCapacityFilled) кг. Отправку разрешаю!")


var toyoace = TrunkCar(brand: .toyota, year: 1990, capacity: 1500, filled: 1280, engine: .on, windows: .open)

toyoace.change(action: .turnEngine(state: .off))
print("Приехали, двигатель в положение \(toyoace.engineState)")
toyoace.change(action: .setWindows(state: .close))
print("Окна в положение \(toyoace.windowsState)")
toyoace.change(action: .unloadFromTrunk(amount: 1500))
print("Грузовик разгрузили, осталось груза на борту: \(toyoace.trunkCapacityFilled) кг")
toyoace.change(action: .turnEngine(state: .on))
print("Двигатель в положении \(toyoace.engineState), сматываемся")
