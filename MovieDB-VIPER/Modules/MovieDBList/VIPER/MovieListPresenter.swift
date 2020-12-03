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
  
  init(interactor: MovieListInteractor)
  var MoviePresenterStatePublished: Published<MoviePresenterStateEnum>.Publisher {get}
  var movies: [MovieEntity] {get set}
  var error: ApiError? { get set }
  
  var router: MovieListRouter {get set}
  var interactor: MovieListInteractor {get set}
  
  func linkBuilder<Content: View>(for movie: MovieEntity, @ViewBuilder content: () -> Content
  ) -> NavigationLink<Content,AnyView>
  
}

final class MovieListFakeErrorPresenter: MovieListPresenterProtocol {
  var MoviePresenterStatePublished:Published<MoviePresenterStateEnum>.Publisher {$MoviePresenterState}
  
  @Published var MoviePresenterState: MoviePresenterStateEnum = .error
  @Published var movies: [MovieEntity] = []
  @Published var error: ApiError?
  
  var router: MovieListRouter =  MovieListRouter()
  var interactor: MovieListInteractor
  
  init(interactor: MovieListInteractor) {
    self.interactor = interactor

  }
  func linkBuilder<Content>(for movie: MovieEntity, content: () -> Content) -> NavigationLink<Content, AnyView> where Content : View {
    NavigationLink(destination: AnyView(EmptyView())) {
      content()
    }
  }
  
}
final class MovieListPresenter: MovieListPresenterProtocol {

  var router: MovieListRouter =  MovieListRouter()
  var interactor: MovieListInteractor
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
  
  
  init(interactor: MovieListInteractor) {
    self.interactor = interactor
    self.bindVariablesToModel()
    request = self.interactor.fetch().on(queue: .main)
      .on(success: { [weak self] data in
        self?.interactor.sucess(for: data.results)
      }, failure: { [weak self] error in
        self?.interactor.error(for: error)
      })
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
