import UIKit

enum ShopErrors: Error {
    case invalidItem
    case outOfStock
    case notEnoughMoney(need: Int)
}

// Чтобы работало .localizedDescription
extension ShopErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidItem:
            return NSLocalizedString("Товар не найден", comment: "")
        case .outOfStock:
            return NSLocalizedString("Товар закончился", comment: "")
        case .notEnoughMoney(let need):
            return NSLocalizedString("У вас недостаточно средств. Ещё нужно \(need) рублей", comment: "")
        }
    }
}

struct Product {
    let name: String
}

struct Item {
    let product: Product
    let price: Int
    var quantity: Int
}

// 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

class GameShop: Error {
    
    private var products = [
        "PS4 Slim": Item(product: Product(name: "PS4 Slim"), price: 29000, quantity: 5),
        "PS4 Pro": Item(product: Product(name: "PS4 Pro"), price: 38000, quantity: 10),
        "PS5 Digital Edition": Item(product: Product(name: "PS5 Digital Edition"), price: 38000, quantity: 0),
        "PS5": Item(product: Product(name: "PS5"), price: 47000, quantity: 0),
        "Xbox One S": Item(product: Product(name: "Xbox One S"), price: 23500, quantity: 7),
        "Xbox Series X": Item(product: Product(name: "Xbox Series X"), price: 45500, quantity: 20),
    ]
    var deposit = 30000
    
    func getPrice(itemName name: String) -> (Int?, ShopErrors?) {
        guard let item = products[name] else {
            return (nil, ShopErrors.invalidItem)
        }
        return (item.price, nil)
    }
    
    func buy(itemName name: String) -> (Product?, ShopErrors?) {
        guard let item = products[name] else {
            return (nil, ShopErrors.invalidItem)
        }
        
        guard item.quantity > 0 else {
            return (nil, ShopErrors.outOfStock)
        }
        
        guard item.price <= deposit else {
            return (nil, ShopErrors.notEnoughMoney(need: item.price - deposit))
            
        }
        
        var newItem = item
        newItem.quantity -= 1
        products[name] = newItem
        deposit -= item.price
        
        return (item.product, nil)
    }
}

let shop = GameShop()
let price = shop.getPrice(itemName: "PS3")

if let product = price.0 {
    print("Стоимость товара: \(product) рублей")
} else if let e = price.1 {
    print("Ошибка: \(e.localizedDescription)")
}

let sell = shop.buy(itemName: "PS5")

if let product = sell.0 {
    print("Ваша покупка: \(product.name)")
} else if let e = sell.1 {
    print("Ошибка: \(e.localizedDescription)")
}



// 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

class CarShop: Error {
    
    private var products = [
        "Honda": Item(product: Product(name: "Honda Civic"), price: 1250000, quantity: 10),
        "Toyota": Item(product: Product(name: "Toyota Supra"), price: 2800000, quantity: 2),
        "Acura": Item(product: Product(name: "Acura NSX"), price: 3500000, quantity: 1),
        "Ferrari": Item(product: Product(name: "F550"), price: 11000000, quantity: 0),
    ]
    var deposit = 3000000
    
    func getPrice(itemName name: String) throws -> Int {
        guard let item = products[name] else {
            throw ShopErrors.invalidItem
        }
        return item.price
    }
    
    func getQuantity(itemName name: String) throws -> Int {
        guard let item = products[name] else {
            throw ShopErrors.invalidItem
        }
        return item.quantity
    }
    
    func buy(itemName name: String) throws -> Product {
        guard let item = products[name] else {
            throw ShopErrors.invalidItem
        }
        
        guard item.quantity > 0 else {
            throw ShopErrors.outOfStock
        }
        
        guard item.price <= deposit else {
            throw ShopErrors.notEnoughMoney(need: item.price - deposit)
            
        }
        
        var newItem = item
        newItem.quantity -= 1
        products[name] = newItem
        deposit -= item.price
        
        return item.product
    }
}


let carShop = CarShop()

do {
    let car = try carShop.buy(itemName: "Toyota")
    print("Я купил себе \(car.name)! Ещё и на мороженку \(carShop.deposit) рублей осталось :)")
} catch let e {
    print(e.localizedDescription)
}

do {
    let car = try carShop.buy(itemName: "Nissan")
    print("А друг мой купил \(car.name)")
} catch let e {
    print(e.localizedDescription)
}

do {
    let price = try carShop.getPrice(itemName: "Nissan")
    print("Стоимость Nissan = \(price)")
} catch let e {
    print(e.localizedDescription)
}

do {
    let price = try carShop.getPrice(itemName: "Ferrari")
    print("Стоимость Ferrari = \(price)")
} catch let e {
    print(e.localizedDescription)
}

do {
    let quantity = try carShop.getQuantity(itemName: "Acura")
    print("На складе осталось автомобилей Acura: \(quantity)")
} catch let e {
    print(e.localizedDescription)
}
