//
//  MovieEntityGenerator.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation


extension MovieEntity {
  private static var fake: MovieEntity {
    MovieEntity(id: 598632,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie",
                popularity: 256548,
                vote_average: "7.1",
                vote_count: 2368,
                poster: "/xoqr4dMbRJnzuhsWDF3XNHQwJ9x.jpg",
                release_date: "2020-10-16")
  }
  
  private static var fake2: MovieEntity {
    MovieEntity(id: 5632,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie",
                popularity: 548,
                vote_average: "9.4",
                vote_count: 2368,
                poster: "/lQfdytwN7eh0tXWjIiMceFdBBvD.jpg",
                release_date: "2019-11-07")
  }
  
  private static var fake3: MovieEntity {
    MovieEntity(id: 5632,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie This is the overview of a TestMovie",
                popularity: 256,
                vote_average: "5.6",
                vote_count: 2368,
                poster: "/kPzcvxBwt7kEISB9O4jJEuBn72t.jpg",
                release_date: "2019-11-07")
  }
  static var getRandomFakeMovie: MovieEntity { [fake,fake2,fake3].randomElement()!}
  
  static var fakes: [MovieEntity] {
    var res: [MovieEntity] = [MovieEntity]()
    for _ in 1...5{
      res.append(MovieEntity.getRandomFakeMovie)
    }
    return res
  }
  
}
