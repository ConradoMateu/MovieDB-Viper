//
//  MovieList.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//


import SwiftUI
import Combine
struct MovieListView: View  {
  var cancellables: Set<AnyCancellable> = []
  var presenter:  MovieListPresenterProtocol
  @State var state: MoviePresenterStateEnum = .empty
  var body: some View {
    VStack{
      switch state{
      case .empty:
        showEmptyView()
      case .error:
        showError()
      case .sucess:
        showListView()
      }
      
    }

.padding([.leading,.trailing],20)
  .padding(.top,10)
  .navigationTitle("Popular")
  .navigationBarHidden(true)
    .onReceive(presenter.MoviePresenterStatePublished){ presenterState in
      self.state = presenterState
    }
    .onAppear(){
      presenter.fetchData()
    }
}

func showEmptyView() -> some View {
  Text("No Movies To Show")
    .foregroundColor(.brand_white)
    .font(.custom(BrandFont.primary, size: .subTitle))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

func showError() -> some View {
  Text("An Error Ocurred")
    .foregroundColor(.brand_red)
    .font(.custom(BrandFont.primary, size: .subTitle))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

func showListView() -> some View {
  VStack(alignment:.leading, spacing: 20){
    VStack(alignment:.leading,spacing:5){
      Text("Popular")
        .bold()
        .font(.custom(BrandFont.primary, size: .title))
        .foregroundColor(.brand_red)
      Divider().background(Color.brand_white)
    }
    
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
    
    let interactor = MovieListFakeInteractor(model: viewModel,movies: MovieEntity.fakes(quantity: 6))
    let presenter = MovieListPresenter(interactor: interactor)
    return MovieListView(presenter: presenter)
      .background(Color.brand_background.edgesIgnoringSafeArea(.all))
  }
}
