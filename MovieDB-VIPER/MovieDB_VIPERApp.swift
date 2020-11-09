//
//  MovieDB_VIPERApp.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 08/11/2020.
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
              .background(Color.brand_background
                            .edgesIgnoringSafeArea(.all))
              .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor(Color.brand_background)
                nc.navigationBar.tintColor = UIColor.red
                              nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                          })
          }      .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
