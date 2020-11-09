//
//  ImageService.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 08/11/2020.
//

import Foundation

public class ImageService {
  static let baseURL = "https://image.tmdb.org/t/p/"
  
  public enum ImageSize: String{
    case small = "w154"
    case medium = "w500"
    case original = "original"
    
  }
  
  static func getUrl(size: ImageSize = .medium,for poster: String) -> URL {
    return URL(string: "\(baseURL)\(size.rawValue)")!.appendingPathComponent(poster)
  }
}
