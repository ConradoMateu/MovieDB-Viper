//
//  APIService.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 08/11/2020.
//


import Foundation

enum Router: Equatable {
  case popular
  
  var url: String {scheme+host}
  var apiKey: String {"1d9b898a212ea52e283351e521e17871"}
  var scheme: String {API.scheme}
  var host: String {API.URL}
  
  
  var path: String {
    switch self {
    case .popular:
      return "/3/movie/popular"
    }
  }
  
  var parameters: [URLQueryItem]? {
    switch self {
    case .popular:
      return [URLQueryItem(name: "api_key", value: apiKey),
              URLQueryItem(name: "page", value: "1"),
              URLQueryItem(name: "language", value: "en-US")]
    default:
      return nil
    }
  }
  
  var method: String {
    switch self {
    case .popular:
      return "GET"
    }
  }
}

struct API {
  static var schemeURL: String {scheme + "://" + URL}
  static var scheme: String {return "https"}
  static var URL: String {
    "api.themoviedb.org"
  }
}

