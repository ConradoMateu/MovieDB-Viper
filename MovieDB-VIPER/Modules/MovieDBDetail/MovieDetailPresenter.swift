//
//  MovieDetailPresenter.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation

class MovieDetailPresenter: ObservableObject {
  
  @Published var movie: MovieEntity
  
  init(movie: MovieEntity) {
    self.movie = movie
  }
}
