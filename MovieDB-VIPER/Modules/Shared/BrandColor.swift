//
//  BrandColor.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 08/11/2020.
//

import Foundation
import SwiftUI
import UIKit

extension UIColor {
  var color: Color {
    Color(self.cgColor)
  }
}


extension Color {
  
  var uiColor: UIColor {
    UIColor(self)
  }
  public static var brand_background: Color {
    Color("brand_background")
  }
  
  public static var brand_bordeaux: Color {
    Color("brand_bordeaux")
  }
  
  public static var brand_gray: Color {
    Color("brand_gray")
  }
  public static var brand_red: Color {
    Color("brand_red")
  }
  public static var brand_white: Color {
    Color("brand_white")
  }
  public static var brand_yellow: Color {
    Color("brand_yellow")
  }
  public static var brand_green: Color {
    Color("brand_green")
  }
  public static var brand_orange: Color {
    Color("brand_orange")
  }
}


