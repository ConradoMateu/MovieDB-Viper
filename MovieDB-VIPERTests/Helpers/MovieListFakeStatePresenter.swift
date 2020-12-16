//
//  MovieListFakeErrorPresenter.swift
//  MovieDB-VIPERTests
//
//  Created by Conrado Mateu on 9/12/20.
//


@testable import MovieDB_VIPER

import Combine
import SwiftUI

final class MovieListFakeStatePresenter: MovieListPresenterProtocol {
  var MoviePresenterStatePublished:Published<MoviePresenterStateEnum>.Publisher {$moviePresenterState}
  
  @Published var moviePresenterState: MoviePresenterStateEnum = .empty
  @Published var movies: [MovieEntity] = []
  @Published var error: ApiError?
  
  var router: MovieListRouter =  MovieListRouter()
  var interactor: MovieListInteractorProtocol
  
  init(interactor: MovieListInteractorProtocol) {
    self.interactor = interactor

  }
  
  convenience init(interactor: MovieListInteractorProtocol, state: MoviePresenterStateEnum) {
    self.init(interactor: interactor)
    self.moviePresenterState = state
  }
  
  func fetchData() {}
  
  func linkBuilder<Content>(for movie: MovieEntity, content: () -> Content) -> NavigationLink<Content, AnyView> where Content : View {
    NavigationLink(destination: AnyView(EmptyView())) {
      content()
    }
  }
  
}
