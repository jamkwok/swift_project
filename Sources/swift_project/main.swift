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

// Inheritence
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


