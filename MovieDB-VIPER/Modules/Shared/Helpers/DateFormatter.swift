//
//  DateFormatter.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 9/12/20.
//

import Foundation

struct Formatter {
  static private var dateFormatter: DateFormatter  {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }
  
  static private var yearFormatter: DateFormatter  {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
  }
  
  //Output: 2018
  static func releaseYear(from releaseDate:String) -> String? {
    guard let date = self.dateFormatter.date(from: releaseDate) else{
      return nil
    }
    return self.yearFormatter.string(from: date)
  }
  


}
