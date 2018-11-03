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


