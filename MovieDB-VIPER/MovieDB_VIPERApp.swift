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
              .configureNavigationBar()
              .onAppear(){
                
                    for familyName in UIFont.familyNames {
                        print("\n-- \(familyName) \n")
                        for fontName in UIFont.fontNames(forFamilyName: familyName) {
                            print(fontName)
                        }
                    }
                
              }
            
          }      
        }
    }
  

}
