//
//  MovieDB_VIPERApp.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 08/11/2020.
//

import SwiftUI

@main
struct MovieDB_VIPERApp: App {
  
  var model = MovieListViewModel()
    var body: some Scene {
        WindowGroup {
          NavigationView {
            MovieListView(presenter:
            MovieListPresenter(interactor:
              MovieListInteractor(model: model)))
          }
        }
    }
}
