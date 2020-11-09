//
//  ServiceLayer.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 08/11/2020.
//

import Foundation
import Combine

enum ApiError: LocalizedError {
  case unknown(Swift.Error)
  case invalidResponse
  case statusCode(Int)
  case invalidData
}

class ServiceLayer {
  
  let session = URLSession.shared
  static let shared = ServiceLayer()
  var cancellableSet: Set<AnyCancellable> = []
  
  func run<T: Decodable>(_ router: Router, params:  [String:Any]? = nil) -> AnyPublisher<T, ApiError> {
    let request = assembleURLRequest(router: router, parameters: params)
    return URLSession.shared.dataTaskPublisher(for: request!)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw ApiError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
          throw ApiError.statusCode(httpResponse.statusCode)
        }
        return data
      }
      .decode(type:T.self, decoder: JSONDecoder())
      .mapError{error -> ApiError in
        if let httpError = error as? ApiError {
          return httpError
        }
        return ApiError.unknown(error)
      }
      .eraseToAnyPublisher()
  }
  
  func assembleURLRequest(router: Router, parameters: [String:Any]? = nil) -> URLRequest? {
    var components = URLComponents()
    components.scheme = router.scheme
    components.host = router.host
    components.path = router.path
    
    if let queryItems = router.parameters {
      components.queryItems = queryItems
    }
    
    guard let url = components.url else { return nil }
    var urlRequest: URLRequest = URLRequest(url: url)
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.httpMethod = router.method
    if let param = parameters{
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
      print(urlRequest.httpBody ?? "")
    }
    return urlRequest
  }
  
  deinit {
    _ = cancellableSet.map{$0.cancel()}
  }
  
}
