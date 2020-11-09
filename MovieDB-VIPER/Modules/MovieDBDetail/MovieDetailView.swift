//
//  MovieDetailView.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import SwiftUI
import FetchImage
struct MovieDetailView: View {
  
  
  @ObservedObject var presenter: MovieDetailPresenter
  
    var body: some View {
      VStack(alignment:.leading, spacing: 30){
        VStack(alignment: .leading, spacing: 20){
          Text("\(presenter.movie.title) (\(presenter.movie.releaseYear ?? ""))")
            .bold()
            .font(.largeTitle)
            .foregroundColor(.red)
          Divider().background(Color.white)
        }
        
        HStack(alignment: .top, spacing: 20){
          ImageView(image: FetchImage(url: presenter.movie.imageURL), posterSize: .big)
          VStack(alignment: .leading){
          
            RatingText(vote_average: presenter.movie.vote_average)
              .font(.title)
            Text("Drama")
              .font(.title3)
              .foregroundColor(.white)
          }.padding(.bottom,5)

          
        }
        VStack(alignment: .leading, spacing: 10){
          Text("Overview:")
            .font(.title2)
            .foregroundColor(.white)
          Text(presenter.movie.overview)
          .font(.subheadline)
          .foregroundColor(.gray)
        }
         
      }.frame(maxHeight: .infinity, alignment: .topLeading)
      .padding([.leading,.trailing], 20)
      .padding([.top,.bottom])

      .background(Color.brand_background.edgesIgnoringSafeArea(.all))
      
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
      let presenter = MovieDetailPresenter(movie: MovieEntity.getRandomFakeMovie)
      
      MovieDetailView(presenter:presenter)
        
    }
}


