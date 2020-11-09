//
//  MovieList.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 09/11/2020.
//

import SwiftUI

struct MovieListView: View {
  
  @ObservedObject var presenter: MovieListPresenter
  var body: some View {
    VStack{
      switch self.presenter.MoviePresenterState {
      case .empty:
        showEmptyView()
      case .error:
        showError()
      case .sucess:
        showListView()
      }
    }.padding([.leading,.trailing],20)
    .navigationTitle("")
    .navigationBarHidden(true)
  }
  
  func showEmptyView() -> some View {
    Text("No Movies To Show")
      .foregroundColor(.white)
      .font(.title2)
      .bold()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  func showError() -> some View {
    Text("An Error Ocurred")
      .foregroundColor(.red)
      .font(.title2)
      .bold()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  func showListView() -> some View {
    VStack(alignment:.leading){
      Text("Popular")
        .bold()
        .font(.largeTitle)
        .foregroundColor(.red)
      
      Divider().background(Color.white)
      ScrollView(showsIndicators: false){
        ForEach(presenter.movies, id: \.self) { id in
          presenter.linkBuilder(for: id){
            MovieRow(movie: id)
          }
        }
      }
    }
  }
}





struct MovieList_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = MovieListViewModel()
    viewModel.initFake()
    let interactor = MovieListInteractor(model: viewModel)
    let presenter = MovieListPresenter(interactor: interactor)
    return MovieListView(presenter: presenter)
      .background(Color.brand_background.edgesIgnoringSafeArea(.all))
  }
}
