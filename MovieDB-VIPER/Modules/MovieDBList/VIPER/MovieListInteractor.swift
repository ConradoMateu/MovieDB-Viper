//
//  MovieListInteractor.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation
import Combine

class MovieListInteractor: ObservableObject {
  @Published var model: MovieListViewModel
  
  init(model: MovieListViewModel) {
    self.model = model
  }
  
  func error(for apiError: ApiError) {
    self.model.error = apiError
  }
  
  func unknownError(for apiError: ApiError) {
    self.model.error = apiError
  }
  
  func sucess(for movies: [MovieEntity]) {
    self.model.movies = movies
  }
  func fetch()  -> AnyPublisher<mainEntity, ApiError>{
    return ServiceLayer.shared.run(Router.popular)
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
