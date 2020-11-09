//
//  BrandColor.swift
//  MovieDB-VIPER
//
//  Created by Emgy on 08/11/2020.
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
    public static var brand_background: Color {
      Color("brand_background")
    }
    
  public static var brand_bordeaux: Color {
        Color("brand_bordeaux", bundle: nil)
      
    }
}


