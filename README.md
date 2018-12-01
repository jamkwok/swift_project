# swift_project 4.2

A simple playground

## Swift strongly typed reference:
```
http://www.aidanf.net/learn-swift/types_and_type_inference
```

## Loops
```
for number in 1...10 where number % 3 == 0{
    print(number)
}

// reversed

for number in (1...10).reversed() where number % 3 == 0{
    print(number)
}
```

## Optionals
```
// Optionals must be unwrapped before use and can be thought of as an enum.
https://medium.com/ios-os-x-development/swift-optionals-78dafaa53f3

//Optional array of strings as a dictionary.
var json: [String : Any]? = [:]
```

## Sets
```
// Sets are like arrays but can contains only unique values, there are a few things you can do with sets.
var mySet1: Set<Int> = [0,1,2,3]
var mySet2: Set<Int> = [0,2,4,6]

// Union combines 2 sets
mySet1.union(mySet2) // [6,4,2,0,1,3]

// Intersection creates a set that has values in both sets.
mySet1.intersection(mySet2) // [2,0]

// Subtract removes values in mySet1 that exist in mySet2
mySet1.subtract(mySet2) // [3,1]
```

## Enums
```
// Is a custom type with fixed options.
enum experienceLevel {
    case Noob
    case Average
    case Pro
}

player1Level: experienceLevel = experienceLevel.Pro

// Shorthand by using leading '.' since player1level is already defined.
switch player1Level {
    .Noob: "Welcome!"
    .Average: "Keep at it!"
    .Pro: "You monster!"
}
```

## Enums Raw Values
```
enum experienceLevel String{
    case Noob = "Welcome!"
    case Average = "Keep at it!"
    case Pro = "You weapon!"
}

player1Level: experienceLevel = experienceLevel.Pro
```

## Fetch Single Json Object and store in Dictionary

```
import Foundation
import Alamofire

let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

// Empty Dictionary Literal, a dictionary is a collection of key value pairs where its empty counter part is [:]
var json: [String : Any]? = [:]

Alamofire.request("https://jsonplaceholder.typicode.com/todos/1")
    .response(
        queue: queue,
        responseSerializer: DataRequest.jsonResponseSerializer(),
        completionHandler: { response in
            switch response.result {
            case .success:
                json = response.result.value as? [String: Any]
            case .failure(let error):
                print(error)
            }
        }    
    )

sleep(5)
print (json)

//Optional binding
print(json?["title"] as? String)
```

## Fetch Json Array and store in Dictionary Array
```
import Foundation
import Alamofire

let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

// Declare 2 dimentional array
var photos: [[String : Any]]?

Alamofire.request("https://jsonplaceholder.typicode.com/albums/1/photos")
    .response(
        queue: queue,
        responseSerializer: DataRequest.jsonResponseSerializer(),
        completionHandler: { response in
            switch response.result {
            case .success:
                photos = response.result.value as? [[String: Any]]
            case .failure(let error):
                print(error)
            }
        }    
    )

sleep(5)

//Default photos to empty array
for photo in photos ?? [] {
    print(photo["title"])
}
```

## Fetch complex Json and store in struct
```
import Foundation
import Alamofire

let decoder = JSONDecoder()
var jsonData: Data = NSData() as Data //Empty Data buffer

// http://www.aidanf.net/learn-swift/types_and_type_inference

let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

// Declare 2 dimentional array
struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Coordinates

        struct Coordinates: Codable {
            let lat: String
            let lng: String
        }
    }

    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

Alamofire.request("https://jsonplaceholder.typicode.com/users")
    .response(
        queue: queue,
        responseSerializer: DataRequest.jsonResponseSerializer(),
        completionHandler: { response in
            switch response.result {
            case .success:
                jsonData = response.data ?? NSData() as Data
            case .failure(let error):
                print(error)
            }
        }    
    )


sleep(5)
let users = try? decoder.decode(Array<User>.self, from: jsonData)
users?.forEach { user in
    print(user.name)
}
```

## Classes
```
// Classes are used to represent objects or things.
// Classes are passed by reference (Always referenced with an address)
// Structs are passed by value (A copy is made)

class Person {
    let name: String
    var age: Int
    let country: String

    init(name: String, age: Int, country: String) {
        self.name = name
        self.age = age
        self.country = country
    }

    func getBirthdayGreetingAndIncrementAge() -> String {
        self.age += 1
        return "Happy birthday \(self.name)"
    }

}

// Inheritance
class Worker: Person {
    let occupation: String

    init(name: String, age: Int, country: String, occupation: String) {
        self.occupation = occupation

        // Initialise the super class which is Person for this example
        super.init(name: name, age: age, country: country)
    }

    //Override function from super class
    override func getBirthdayGreetingAndIncrementAge() -> String {
        self.age += 1
        return "Happy birthday \(self.name) (\(self.occupation))"
    }

    func getOccupation() -> String {
        return self.occupation
    }
}

var person1: Person = Person(name: "Kate", age: 22, country: "Belarus")
print(person1.getBirthdayGreetingAndIncrementAge())

var worker1: Worker = Worker(name: "James", age: 30, country: "Australia", occupation: "Engineer")
print(worker1.getOccupation())
print(worker1.getBirthdayGreetingAndIncrementAge())

// Polymorphism change type based on context, worker gets treated as a person for this context.
var people: [Person] = [person1, worker1]
```