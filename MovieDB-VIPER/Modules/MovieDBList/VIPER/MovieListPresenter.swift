//
//  MovieListPresenter.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation

import Combine
import SwiftUI


protocol MovieListPresenterProtocol {
  
  init(interactor: MovieListInteractorProtocol)
  var MoviePresenterStatePublished: Published<MoviePresenterStateEnum>.Publisher {get}
  var movies: [MovieEntity] {get set}
  var error: ApiError? { get set }
  
  var router: MovieListRouter {get set}
  var interactor: MovieListInteractorProtocol {get set}
  
  func linkBuilder<Content: View>(for movie: MovieEntity, @ViewBuilder content: () -> Content
  ) -> NavigationLink<Content,AnyView>
  
}

final class MovieListPresenter: MovieListPresenterProtocol {

  var router: MovieListRouter =  MovieListRouter()
  var interactor: MovieListInteractorProtocol
  var request: AnyCancellable?

  var MoviePresenterStatePublished:Published<MoviePresenterStateEnum>.Publisher {$MoviePresenterState}
  
  @Published var MoviePresenterState: MoviePresenterStateEnum = .empty
  private var cancellables = Set<AnyCancellable>()

  

  @Published var movies: [MovieEntity] = [] {
    didSet{
      if(movies != []){
        MoviePresenterState = .sucess
      }
    }
  }
  
  @Published var error: ApiError? {
    didSet{
      if(error != nil){
        MoviePresenterState = .error
      }
    }
  }
  
  
  init(interactor: MovieListInteractorProtocol) {
    self.interactor = interactor
    self.bindVariablesToModel()
    request = self.interactor.fetchData()
  }
  
  func linkBuilder<Content>(for movie: MovieEntity, content: () -> Content) -> NavigationLink<Content, AnyView> where Content : View {
    NavigationLink(destination: AnyView(router.makeDetailView(for: movie))) {
      content()
    }
  }

  func bindVariablesToModel(){
    self.interactor.model.$movies
      .assign(to: \.movies, on: self)
      .store(in: &cancellables)
    self.interactor.model.$error
      .assign(to: \.error, on: self)
      .store(in: &cancellables)
  }
  

}

public enum MoviePresenterStateEnum {
  case empty, sucess, error
}
