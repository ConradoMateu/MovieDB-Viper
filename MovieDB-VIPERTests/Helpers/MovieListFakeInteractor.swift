//
//  MovieListFakeInteractor.swift
//  MovieDB-VIPERTests
//
//  Created by Conrado Mateu on 9/12/20.
//

@testable import MovieDB_VIPER

import Combine
import SwiftUI

class MovieListFakeInteractor: ObservableObject, MovieListInteractorProtocol {
  @Published var model: MovieListViewModel
  
  var data: MainEntity
  init(model: MovieListViewModel) {
    self.model = model
    self.data = MovieEntity.fakes.toMain()
  }
  
  convenience init(model: MovieListViewModel,movies: [MovieEntity]) {
    self.init(model: model)
    self.data = movies.toMain()
  }
  
  func error(for apiError: ApiError) {
    self.model.error = apiError
  }
  
  func sucess(for movies: [MovieEntity]) {
    self.model.movies = movies
  }
  func getPopular()  -> AnyPublisher<MainEntity, ApiError>{

    return Just((self.data))
                .setFailureType(to: ApiError.self)
                .eraseToAnyPublisher()
  }
  
  func fetchData() -> AnyCancellable{
    return self.getPopular().on(queue: .main)
  .on(success: { [weak self] data in
    print(data)
    self?.sucess(for: data.results)
  }, failure: { [weak self] error in
    print(error)
    self?.error(for: error)
  })
  }
}


extension Array where Element == MovieEntity {
    func toMain() -> MainEntity {
      return MainEntity(page: 1, results: self)
    }
}
