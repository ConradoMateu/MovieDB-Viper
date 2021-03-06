//
//  MovieListViewModel.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation
import Combine
import SwiftUI


final class MovieListViewModel: ObservableObject {
 
    let objectWillChange = ObservableObjectPublisher()
   
    @Published var error: ApiError? = nil {
        willSet {
            self.objectWillChange.send()
        }
    }

    @Published var movies: [MovieEntity] = [] {
       willSet {
            self.objectWillChange.send()
        print("Changed")
        }
    }
  
  func error(for apiError: ApiError) {
    self.error = apiError
  }
  
  func sucess(for movies: [MovieEntity]) {
    self.movies = movies
  }
  
}
  
  

