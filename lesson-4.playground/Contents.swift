import UIKit

enum Brands: String {
    case honda = "Honda"
    case toyota = "Toyota"
    case alfaRomeo = "Alfa Romeo"
    case mazda = "Mazda"
}

enum Transmission {
    case at, mt, cvt
}

enum EngineState {
    case on, off
}

enum OpenCloseState {
    case open, close
}

enum CarActions {
    case turnEngine(state: EngineState)
    case setWindows(state: OpenCloseState)
    case loadTrunk(amount: Int)
    case unloadTrunk(amount: Int)
    case handleHatch(state: OpenCloseState)
}


class Car {
    
    let brand: Brands
    let year: Int
    var engineState: EngineState
    var windowsState: OpenCloseState
    
    init(brand: Brands,
         year: Int,
         engineState: EngineState,
         windowsState: OpenCloseState)
    {
        self.brand = brand
        self.year = year
        self.engineState = engineState
        self.windowsState = windowsState
    }
    
    func action(_ action: CarActions) {
        
        switch action {
        case let .turnEngine(state):
            self.engineState = state
            
        case let .setWindows(state):
            self.windowsState = state
            
        default:
            break
        }
    }
}


class TrunkCar: Car {
    
    let capacity: Int
    var capacityLoaded: Int
    var capacityFree: Int {
        get {
            return self.capacity - self.capacityLoaded
        }
    }
    
    init(brand: Brands,
         year: Int,
         engineState: EngineState,
         windowsState: OpenCloseState,
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
        
        self.capacity = _capacity
        self.capacityLoaded = _loaded
        
        super.init(brand: brand, year: year, engineState: engineState, windowsState: windowsState)
    }
    
    override func action(_ action: CarActions) {
        super.action(action)
        
        switch action {
        case let .loadTrunk(amount):
            if self.capacityFree >= amount {
                self.capacityLoaded += amount
            } else {
                print("\(amount) кг не влезет. У нас осталось свободного места всего для \(self.capacityFree) кг груза")
            }
            
        case let .unloadTrunk(amount):
            if self.capacityLoaded < amount {
                print("Вы пытаетесь разгрузить \(amount) кг, а у нас всего \(self.capacityLoaded) кг. Выгрузили всё, что смогли")
                self.capacityLoaded = 0
            } else {
                self.capacityLoaded -= amount
            }
            
        default:
            break
        }
    }
}


class SportCar: Car {
    
    let transmission: Transmission
    let horsePower: Int
    let maxSpeed: Int
    var hatchState: OpenCloseState
    
    init(brand: Brands,
         year: Int,
         engineState: EngineState,
         windowsState: OpenCloseState,
         transmission: Transmission,
         horsePower: Int,
         maxSpeed: Int,
         hatchState: OpenCloseState)
    {
        self.transmission = transmission
        self.horsePower = horsePower
        self.maxSpeed = maxSpeed
        self.hatchState = hatchState
        
        super.init(brand: brand, year: year, engineState: engineState, windowsState: windowsState)
    }
    
    override func action(_ action: CarActions) {
        super.action(action)
        
        switch action {
        case let .handleHatch(state):
            self.hatchState = state
            
        default:
            break
        }
    }
}


var civic = SportCar(brand: .honda,
                     year: 2003,
                     engineState: .off,
                     windowsState: .open,
                     transmission: .mt,
                     horsePower: 230,
                     maxSpeed: 210,
                     hatchState: .close)

civic.action(.turnEngine(state: .on))
civic.action(.setWindows(state: .open))
civic.action(.handleHatch(state: .open))

print(civic.brand.rawValue)
print("Люк в положении \(civic.hatchState)")
print("Статус двигателя:", civic.engineState)
print("Положение окон:", civic.windowsState)


var julia = SportCar(brand: .alfaRomeo,
                     year: 2015,
                     engineState: .off,
                     windowsState: .open,
                     transmission: .at,
                     horsePower: 350,
                     maxSpeed: 300,
                     hatchState: .open)

julia.action(.turnEngine(state: .on))
julia.action(.setWindows(state: .close))
julia.action(.handleHatch(state: .close))

print(julia.brand.rawValue)
print("Люк в положении \(civic.hatchState)")
print("Статус двигателя:", julia.engineState)
print("Положение окон:", julia.windowsState)


var bongo = TrunkCar(brand: .mazda,
                     year: 1998,
                     engineState: .off,
                     windowsState: .open,
                     capacity: 1000,
                     capacityLoaded: 400)

bongo.action(.loadTrunk(amount: 960))
bongo.action(.loadTrunk(amount: 330))
bongo.action(.unloadTrunk(amount: 500))
bongo.action(.turnEngine(state: .on))
bongo.action(.setWindows(state: .open))

print("В машину загружено \(bongo.capacityLoaded) кг груза. Можно загрузить ещё \(bongo.capacityFree) кг")
print("Статус авто \(bongo.brand.rawValue) (\(bongo.year) г.в.): Окна в положении \(bongo.windowsState), двигатель в положении \(bongo.engineState), объём груза на борту \(bongo.capacityLoaded) кг. Отправку разрешаю!")


var toyoace = TrunkCar(brand: .toyota,
                       year: 1990,
                       engineState: .on,
                       windowsState: .open,
                       capacity: 1500,
                       capacityLoaded: 2000)

toyoace.action(.turnEngine(state: .off))
toyoace.action(.setWindows(state: .close))
toyoace.action(.unloadTrunk(amount: 1500))
toyoace.action(.turnEngine(state: .on))

print("Приехали, двигатель в положение \(toyoace.engineState)")
print("Окна в положение \(toyoace.windowsState)")
print("Грузовик разгрузили, осталось груза на борту: \(toyoace.capacityLoaded) кг")
print("Двигатель в положении \(toyoace.engineState), сматываемся")
