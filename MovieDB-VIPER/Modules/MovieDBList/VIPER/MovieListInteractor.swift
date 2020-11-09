//
//  MovieListInteractor.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 09/11/2020.
//

import Foundation
import Combine

class MovieListInteractor: ObservableObject {
  @Published var model: MovieListViewModel
  
  init(model: MovieListViewModel) {
    self.model = model
  }
  var apierror: ApiError? {
    self.model.error
  }
  
  
  var can2: AnyCancellable?
//  func fetch() {
//    can2 = ServiceLayer.shared.run(Router.popular)
//
//      .on(success: { [weak self]  (res: [MovieEntity]) in
//          self!.model.sucess(for: res)
//      }, failure: { [weak self] error in
//        self!.model.error(for: error)
//      })
//
//  }
  
    func fetch() -> AnyPublisher<mainEntity, ApiError>{
      let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=1d9b898a212ea52e283351e521e17871&language=en-US&page=1")!
      let request = URLRequest(url: url)
      return URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { data, response in
          guard let httpResponse = response as? HTTPURLResponse else {
              throw ApiError.invalidResponse
          }
          guard httpResponse.statusCode == 200 else {
              throw ApiError.statusCode(httpResponse.statusCode)
          }
          return data
      }
      .decode(type: mainEntity.self, decoder: JSONDecoder())
      .mapError { error -> ApiError in
          if let httpError = error as? ApiError {
              return httpError
          }
          return ApiError.unknown(error)
      }
      .eraseToAnyPublisher()
  }
}


public extension Publisher {

    func on(queue: DispatchQueue) -> Publishers.ReceiveOn<Self, DispatchQueue> {
        self.receive(on: queue, options: nil)
    }

    func on(success: @escaping ((Self.Output) -> Void),
            failure: @escaping ((Self.Failure) -> Void)) -> AnyCancellable {
        self.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                failure(error)
            case .finished:
                break
            }
        }, receiveValue: success)
    }
}
