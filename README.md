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

// http://www.aidanf.net/learn-swift/types_and_type_inference

let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

// Empty Dictionary Literal
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

// http://www.aidanf.net/learn-swift/types_and_type_inference

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

//Optional binding
for photo in photos ?? [] {
    print(photo["title"])
}
```