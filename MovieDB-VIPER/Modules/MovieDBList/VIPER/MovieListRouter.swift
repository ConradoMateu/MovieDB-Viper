//
//  MovieListRouter.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation
import SwiftUI

class MovieListRouter {
  func makeDetailView(for movie: MovieEntity) -> some View {
    let presenter = MovieDetailPresenter(movie: movie)
    return MovieDetailView(presenter: presenter)
  }
}
