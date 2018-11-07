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



