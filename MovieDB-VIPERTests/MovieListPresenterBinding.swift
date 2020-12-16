//
//  MovieListPresenterBinding.swift
//  MovieDB-VIPERTests
//
//  Created by Conrado Mateu on 9/12/20.
//

import XCTest
@testable import MovieDB_VIPER

import Combine
import SwiftUI

class MovieListPresenterBinding: XCTestCase {
  
  var viewModel: MovieListViewModel!
  var interactor: MovieListInteractorProtocol!
  var presenter: MovieListPresenter!
  var testMovies: [MovieEntity] = MovieEntity.fakes(quantity: 5)
  var cancellables = Set<AnyCancellable>()
  
  
  func testShouldCheckThatInitialPresenterStateIsEmpty() throws {
    
    //Given (Initial SetUp)
    setUpSucessFetching()
    
    //When (Nothing, Initial State)
    
    //Then
    XCTAssertEqual(presenter.moviePresenterState, .empty)
    XCTAssertEqual(presenter.movies, [])
    
  }
  
  func testShouldUpdatePresenterStateAndModelWhenFetchData() throws {
    
    // Given (Initial SetUp)
    setUpSucessFetching()
    
    // When
    
    self.presenter.fetchData()
    
    let movieSuccessStateExpectation = self.expectation(description: "waiting to success state")
    let presenterMoviesPopulatedExpectation = self.expectation(description: "waiting to recieve movies")
    self.presenter.$movies.sink{mov in
      if !mov.isEmpty{
        presenterMoviesPopulatedExpectation.fulfill()
      }
    }.store(in: &cancellables)
    self.presenter.$moviePresenterState.sink{state in
      if state == .sucess{
        movieSuccessStateExpectation.fulfill()
      }
    }.store(in: &cancellables)
    
    // Then
    
    waitForExpectations(timeout: 10)
    XCTAssertEqual(presenter.moviePresenterState, .sucess)
    XCTAssertEqual(presenter.movies, testMovies)
  }
  
  func testShouldUpdateErrorWhenFetchingData() throws {
    
    // Given (Initial SetUp)
    setUpFailFetching()
    
    // When
    
    self.presenter.fetchData()
    
    let movieSuccessStateExpectation = self.expectation(description: "waiting to error state")
    let presenterMoviesPopulatedExpectation = self.expectation(description: "empty movies")
    self.presenter.$movies.sink{mov in
      if mov.isEmpty{
        presenterMoviesPopulatedExpectation.fulfill()
      }
    }.store(in: &cancellables)
    self.presenter.$moviePresenterState.sink{state in
      if state == .error{
        movieSuccessStateExpectation.fulfill()
      }
    }.store(in: &cancellables)
    
    // Then
    
    waitForExpectations(timeout: 10)
    XCTAssertEqual(presenter.moviePresenterState, .error)
    XCTAssertEqual(presenter.movies, [])
  }
}


extension MovieListPresenterBinding{
  func setUpSucessFetching() {
    self.viewModel = MovieListViewModel()
    self.interactor = MovieListFakeInteractor(model: self.viewModel, movies: testMovies)
    self.presenter = MovieListPresenter(interactor: self.interactor)
  }
  
  func setUpFailFetching() {
    self.viewModel = MovieListViewModel()
    self.interactor = MovieListFakeErrorInteractor(model: self.viewModel)
    self.presenter = MovieListPresenter(interactor: self.interactor)
  }
}


