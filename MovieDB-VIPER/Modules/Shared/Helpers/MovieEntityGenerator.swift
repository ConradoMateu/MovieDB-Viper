//
//  MovieEntityGenerator.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation


extension MovieEntity {
  static var randomId: Int {Int.random(in: 1...99999)}
  private static var fake: MovieEntity {
    MovieEntity(id: randomId,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie",
                popularity: 256548,
                vote_average: "7.1",
                vote_count: 2368,
                poster: "/xoqr4dMbRJnzuhsWDF3XNHQwJ9x.jpg",
                release_date: "2020-10-16",
                genre: MovieGenres.getRandom)
  }
  
  private static var fake2: MovieEntity {
    MovieEntity(id: randomId,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie",
                popularity: 548,
                vote_average: "9.4",
                vote_count: 2368,
                poster: "/lQfdytwN7eh0tXWjIiMceFdBBvD.jpg",
                release_date: "2019-11-07",
                genre: MovieGenres.getRandom)
  }
  
  private static var fake3: MovieEntity {
    MovieEntity(id: randomId,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie",
                popularity: 256,
                vote_average: "5.6",
                vote_count: 2368,
                poster: "/kPzcvxBwt7kEISB9O4jJEuBn72t.jpg",
                release_date: "2019-11-07",
                genre:  MovieGenres.getRandom)
  }
  static var getRandomFakeMovie: MovieEntity { [fake,fake2,fake3].randomElement()!}
  
  static func fakes(quantity: Int) -> [MovieEntity] {
    var res: [MovieEntity] = [MovieEntity]()
    for _ in 1...quantity{
      res.append(MovieEntity.getRandomFakeMovie)
    }
    return res
  }
  static var fakes: [MovieEntity] { fakes(quantity: 5)}
  
}
