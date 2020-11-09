//
//  RatingText.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import SwiftUI

struct RatingText: View {
  
  let vote_average: String
  var rating: Int { Int(Double(vote_average)! * 10)}
  var scoreColor: Color {
    get {
      if rating < 40 {
        return .red
      } else if rating < 60 {
        return .orange
      } else if rating < 75 {
        return .yellow
      }
      return .green
    }
  }
  var body: some View {
    Text("\(rating)%")
      .foregroundColor(scoreColor)
      .bold()
  }
}
