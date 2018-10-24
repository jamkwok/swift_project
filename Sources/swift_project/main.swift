import Foundation
import Alamofire

print("Helloworld")

let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

Alamofire.request("http://httpbin.org/get", parameters: ["foo": "bar"])
    .response(
        queue: queue,
        responseSerializer: DataRequest.jsonResponseSerializer(),
        completionHandler: { response in
            // You are now running on the concurrent `queue` you created earlier.
            print("Parsing JSON on thread: \(Thread.current) is main thread: \(Thread.isMainThread)")

            // Validate your JSON response and convert into model objects if necessary
            print(response.result.value)

            // To update anything on the main thread, just jump back on like so.
            DispatchQueue.main.async {
                print("Am I back on the main thread: \(Thread.isMainThread)")
            }
        }
    )

    sleep(5)
