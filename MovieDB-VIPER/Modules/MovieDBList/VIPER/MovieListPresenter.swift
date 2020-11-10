//
//  MovieListPresenter.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation

import Combine
import SwiftUI

final class MovieListPresenter: ObservableObject {
  
  private var cancellables = Set<AnyCancellable>()
  private var router: MovieListRouter =  MovieListRouter()
  private var interactor: MovieListInteractor
  var request: AnyCancellable?
  
  @Published var MoviePresenterState: MoviePresenterStateEnum = .empty
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
  
  func linkBuilder<Content: View>(for movie: MovieEntity, @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: movie)) {
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
  
  enum MoviePresenterStateEnum {
    case empty, sucess, error
  }
  
}
