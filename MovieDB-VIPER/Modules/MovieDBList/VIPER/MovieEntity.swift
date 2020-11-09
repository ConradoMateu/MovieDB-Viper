//
//  MovieEntity.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 08/11/2020.
//

import Foundation

class MovieEntity:  Codable, Identifiable, Hashable {
  static func == (lhs: MovieEntity, rhs: MovieEntity) -> Bool {
    lhs.id == rhs.id
  }
  
  let id: Int
  let original_title: String
  let title: String
  let overview: String
  let popularity: Double
  let vote_average: String
  let vote_count: Int
  let poster: String
  let release_date: String
  var releaseDate: Date? {
      return MovieEntity.dateFormatter.date(from: release_date)
  }
  var imageURL: URL {
    return ImageService.getUrl(for: poster)
  }
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)
  }
  enum CodingKeys: String, CodingKey {
      case id
      case original_title
      case title
    case overview
      case popularity
      case vote_average
      case vote_count
      case poster = "poster_path"
    case release_date
  }
  
  required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(Int.self, forKey: .id)
    original_title = try values.decode(String.self, forKey: .original_title)
    title = try values.decode(String.self, forKey: .title)
    overview = try values.decode(String.self, forKey: .overview)
    popularity = try values.decode(Double.self, forKey: .popularity)
    vote_average = String(try values.decode(Double.self, forKey: .vote_average))
    vote_count = try values.decode(Int.self, forKey: .vote_count)
      poster = try values.decode(String.self, forKey: .poster)
    release_date = (try? values.decode(String.self, forKey: .release_date)) ?? "2020-11-11"
  }
  
  init(id: Int,
  original_title: String,
  title: String,
  overview: String,
  popularity: Double,
  vote_average: String,
  vote_count: Int,
  poster: String,
  release_date: String) {
    self.id = id
    self.title = title
    self.original_title = original_title
    self.overview = overview
    self.popularity = popularity
    self.vote_average = vote_average
    self.vote_count = vote_count
    self.poster = poster
    self.release_date = release_date
  }

}

extension MovieEntity {
  
}

extension MovieEntity{
  static let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyy-MM-dd"
      return formatter
  }()
}

extension MovieEntity {
  static var fake: MovieEntity {
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
  
  static var fake2: MovieEntity {
    MovieEntity(id: 5632,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie",
                popularity: 548,
                vote_average: "9.4",
                vote_count: 2368,
                poster: "/lQfdytwN7eh0tXWjIiMceFdBBvD.jpg",
                release_date: "2019-11-07")
  }
  
  static var fake3: MovieEntity {
    MovieEntity(id: 5632,
                original_title: "Test Movie",
                title: "Test Test Movie",
                overview: "This is the overview of a TestMovie",
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

struct mainEntity: Decodable {
  let page: Int
  let results: [MovieEntity]
}
