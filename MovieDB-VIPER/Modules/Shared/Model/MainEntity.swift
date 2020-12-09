//
//  MainEntity.swift
//  MovieDB-VIPER
//
//  Created by Conrado Mateu on 9/12/20.
//

import Foundation


struct MainEntity: Codable {
  let page: Int
  let results: [MovieEntity]
}
