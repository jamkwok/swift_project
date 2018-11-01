import Foundation
import Alamofire

// https://theswiftdev.com/2018/07/10/ultimate-grand-central-dispatch-tutorial-in-swift/

// https://www.sitepoint.com/improve-swift-closures-result/

print("invoking")

var flag = false
let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

Alamofire.request("http://httpbin.org/get", parameters: ["foo": "bar"])
    .response(
        queue: queue,
        responseSerializer: DataRequest.jsonResponseSerializer(),
        completionHandler: { response in
            print("calling out")
            flag = true
        }
    )

sleep(5)
print(flag)
