//
//  RatingText.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import SwiftUI

struct RatingText: View {
  
  let vote_average: String
  let large: Bool
  var rating: Int { Int(Double(vote_average)! * 10)}
  
  
  init(vote_average: String, large: Bool = false) {
    self.vote_average = vote_average
    self.large = large
  }
  var title: String {
    large ? "\(rating)% User Score" : "\(rating)%"
  }
  var scoreColor: Color {
    get {
      if rating < 40 {
        return .brand_red
      } else if rating < 60 {
        return .brand_orange
      } else if rating < 75 {
        return .brand_yellow
      }
      return .brand_green
    }
  }
  var body: some View {
    Text(title)
      .foregroundColor(scoreColor)
      .font(.custom(BrandFont.secondary, size:large ? .subTitle : .subTitle2))
  }
}
