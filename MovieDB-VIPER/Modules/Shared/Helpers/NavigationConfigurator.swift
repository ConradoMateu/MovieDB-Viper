//
//  NavigationConfigurator.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 09/11/2020.
//

import Foundation
import SwiftUI

struct ConfigureNavigation: ViewModifier {
  
    func body(content: Content) -> some View {
        return content
          .background(NavigationConfigurator { nc in
            nc.navigationBar.barTintColor = Color.brand_background.uiColor
            nc.navigationBar.tintColor = Color.brand_red.uiColor
            nc.navigationBar.titleTextAttributes = [.foregroundColor : Color.brand_white.uiColor]
                      })
          .navigationBarTitleDisplayMode(.inline)
          .navigationViewStyle(StackNavigationViewStyle())
    }
  
  struct NavigationConfigurator: UIViewControllerRepresentable {
      var configure: (UINavigationController) -> Void = { _ in }

      func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
          UIViewController()
      }
      func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
          if let nc = uiViewController.navigationController {
              self.configure(nc)
          }
      }
  }
}

extension View {
    func configureNavigationBar() -> some View {
        return ModifiedContent(content: self, modifier: ConfigureNavigation())
    }
}
