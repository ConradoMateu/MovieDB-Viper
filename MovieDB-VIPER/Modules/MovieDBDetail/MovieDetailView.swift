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
        HStack{
          Text("\(presenter.movie.title) (\(presenter.movie.releaseYear ?? ""))")
            .font(.custom(BrandFont.primary, size: .title2))
            .foregroundColor(.brand_red)
        }
        
        Divider().background(Color.white)
      }
      
      HStack(alignment: .top, spacing: 20){
        ImageView(image: FetchImage(url: presenter.movie.imageURL), posterSize: .big)
        VStack(alignment: .leading){
          HStack{
            RatingText(vote_average: presenter.movie.vote_average, large: true)
          }
          
          Text(presenter.movie.genre)
            .font(.custom(BrandFont.secondary, size: .subTitle))
            .font(.title3)
            .foregroundColor(.brand_white)
        }.padding(.bottom,5)
        
        
      }
      VStack(alignment: .leading, spacing: 10){
        Text("Overview:")
          .font(.custom(BrandFont.secondary, size: .subTitle))
          .foregroundColor(.white)
        Text(presenter.movie.overview)
          .font(.custom(BrandFont.secondary, size: .footnote))
          .foregroundColor(.brand_gray)
      }
      
    }.frame(maxHeight: .infinity, alignment: .topLeading)
    .padding([.leading, .trailing],20)
    .padding(.top,30)
    .background(Color.brand_background.edgesIgnoringSafeArea(.all))
    
  }
}

struct MovieDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let presenter = MovieDetailPresenter(movie: MovieEntity.getRandomFakeMovie)
    MovieDetailView(presenter:presenter)
    
  }
}


