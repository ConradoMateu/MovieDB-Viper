//
//  MovieListFakeErrorInteractor.swift
//  MovieDB-VIPERTests
//
//  Created by Conrado Mateu on 14/12/20.
//

@testable import MovieDB_VIPER

import Combine
import SwiftUI

class MovieListFakeErrorInteractor: ObservableObject, MovieListInteractorProtocol {
  var anyCancellables = Set<AnyCancellable>()
  var canc: AnyCancellable?
  
  @Published var model: MovieListViewModel
  
  init(model: MovieListViewModel) {
    self.model = model
  }
  
  func error(for apiError: ApiError) {
    self.model.error = apiError
  }
  
  func sucess(for movies: [MovieEntity]) {
    self.model.movies = movies
  }
  

  
  func fetchData() -> AnyCancellable{
    doRequest()
      .on(queue: .main)
      .on(success: {err in self.sucess(for: err.results)}, failure: {e in self.error(for: e)})
  }
  
  private func doRequest() -> AnyPublisher<MainEntity, ApiError> {
      // In the real world this does a request to a REST API, returning either a User object or an error containing a Challenge.
    return Fail(outputType: MainEntity .self, failure: ApiError.invalidData)
        .eraseToAnyPublisher()
    }
}





