import Alamofire
  print("Calling...")
  Alamofire.request( "http://httpbin.org/get", parameters: ["foo": "bar"])
  .responseJSON   { response in
    print("Hello, world!")
    print(response)
  }
  print("Done!!")

