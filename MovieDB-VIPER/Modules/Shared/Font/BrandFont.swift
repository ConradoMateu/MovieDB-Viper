//
//  BrandFont.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 10/11/2020.
//

import Foundation
import SwiftUI

struct BrandFont {
  public static let primary: String = "CooperBlackStd"
  public static let secondary: String = "BwSurco-Book"
}


enum TextType: CGFloat {
  case title = 60
  case title2 = 30
  case subTitle = 20
  case subTitle2 = 16
  case footnote = 14
}

extension Font {
    static func custom(_ name: String, size: TextType) -> Font {
    return Font.custom(name, size: size.rawValue)
  }
}

