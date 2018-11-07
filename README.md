# swift_project

A simple playground

## Swift strongly typed reference:
```
http://www.aidanf.net/learn-swift/types_and_type_inference
```

## Optionals
```
https://medium.com/ios-os-x-development/swift-optionals-78dafaa53f3
```

## Fetch Single Json Object

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

## Fetch Json Array
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

### Fetch complex Json and store in struct
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