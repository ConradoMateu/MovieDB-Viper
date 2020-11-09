//
//  MovieRow.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 08/11/2020.
//

import SwiftUI
import Nuke
import FetchImage
struct MovieRow: View {
  let movie: MovieEntity
  
    var body: some View {
      HStack(alignment: .top){
        ImageView(image: FetchImage(url: movie.imageURL))
        VStack(alignment: .leading){
          Text(movie.title)
            .font(.title2)
            .bold()
            .foregroundColor(.red)
          HStack{
            
            RatingText(vote_average: movie.vote_average)
            Spacer()
            if let releaseDate = movie.release_date{
              Text(releaseDate).foregroundColor(.blue)
            }
            
          }.padding(.bottom,5)
          Text(movie.overview)
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.bottom, 10)
          
        }
      }.frame(minWidth: 0, maxWidth: .infinity,maxHeight: 200, alignment: .center)

    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
      VStack{
        MovieRow(movie: MovieEntity.getRandomFakeMovie)
        MovieRow(movie: MovieEntity.getRandomFakeMovie)
        MovieRow(movie: MovieEntity.getRandomFakeMovie)
        MovieRow(movie: MovieEntity.getRandomFakeMovie)
        MovieRow(movie: MovieEntity.getRandomFakeMovie)
      }.padding([.leading,.trailing],20)
      .background(Color.brand_background.edgesIgnoringSafeArea(.all))
    }
}


