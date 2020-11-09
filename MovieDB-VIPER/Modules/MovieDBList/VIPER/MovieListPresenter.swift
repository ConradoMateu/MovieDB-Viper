//
//  MovieListPresenter.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 09/11/2020.
//

import Foundation

import Combine
import SwiftUI

final class MovieListPresenter: ObservableObject {

    var router: MovieListRouter =  MovieListRouter()
    var interactor: MovieListInteractor
  var request: AnyCancellable?
  @Published var movies: [MovieEntity] = [] {
    didSet{
      if(movies != []){
        MoviePresenterState = .sucess
        print(movies.description)
      }
      
      
    }
  }
  @Published var error: ApiError? {
    didSet{
      MoviePresenterState = .error
    }
  }
  
  @Published var MoviePresenterState: MoviePresenterStateEnum = .empty
  enum MoviePresenterStateEnum {
    case empty, sucess, error
  }

  private var cancellables = Set<AnyCancellable>()
  
  init(interactor: MovieListInteractor) {
    self.interactor = interactor
    self.interactor.model.$movies
      .assign(to: \.movies, on: self)
      .store(in: &cancellables)
    request = self.interactor.fetch().on(queue: .main)
      .on(success: { [weak self] data in
        self?.movies = data.results
      }, failure: { [weak self] error in
        self?.error = error
      })
  }
  
  func linkBuilder<Content: View>(for movie: MovieEntity, @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: movie)) {
      content()
    }
  }
  
}
