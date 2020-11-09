//
//  MovieRow.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 08/11/2020.
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
            if let releaseDate = movie.release_date{
              Text(releaseDate)
            }
            Spacer()
            RatingText(vote_average: movie.vote_average)
          }.padding(.bottom,5)
          
          Text(movie.overview)
            .font(.footnote)
            .foregroundColor(.gray)
          
        }
      }.frame(minWidth: 0, maxWidth: .infinity,maxHeight: 200, alignment: .center)

    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
      MovieRow(movie: MovieEntity.fake)
        .padding([.leading,.trailing],20)
    }
}


