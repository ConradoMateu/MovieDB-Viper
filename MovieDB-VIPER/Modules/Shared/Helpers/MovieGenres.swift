//
//  MovieGenres.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation

enum MovieGenres: Int {
  case action = 28,
       adventure = 12,
       animation = 16,
       comedy = 35,
       crime = 80,
       documentary = 99,
       drama = 18,
       family = 10751,
       fantasy = 14,
       history = 36,
       horror = 27,
       music = 10402,
       mystery = 9648,
       romance = 10749,
       scienceFiction = 878,
       tvMovie = 10770,
       thriller = 53,
       war = 10752,
       western = 37

  
  private static var dictConverter: [MovieGenres: String] {
    [self.action : "Action",
     self.adventure: "Adventure",
     self.animation: "Animation",
     self.comedy: "Comedy",
     self.crime: "Crime",
     self.documentary: "Documentary",
     self.drama: "Drama",
     self.family: "Family",
     self.fantasy: "Fantasy",
     self.history: "History",
     self.horror: "Horror",
     self.music: "Music",
     self.mystery: "Mystery",
     self.romance: "Romance",
     self.scienceFiction: "Science Fiction",
     self.tvMovie: "TV Movie",
     self.thriller: "Thriller",
     self.war: "War",
     self.western: "Western"]
  }
}

extension MovieGenres {
  func toString(for movie: MovieGenres) -> String {
    MovieGenres.dictConverter[movie]!
  }
}
