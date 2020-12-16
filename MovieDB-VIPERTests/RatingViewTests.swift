//
//  RatingViewTests.swift
//  MovieDB-VIPERTests
//
//  Created by Conrado Mateu on 16/12/20.
//

import XCTest
@testable import MovieDB_VIPER

import Combine
import SwiftUI

class RatingViewTests: XCTestCase {

    func testGreenColor() throws {
      let ratingView = RatingText(vote_average: "8")
      XCTAssertEqual(ratingView.rating,80)
      XCTAssertEqual(ratingView.scoreColor,.brand_green)
    }
  
  func testYellowColor() throws {
    let ratingView = RatingText(vote_average: "6.8")
    XCTAssertEqual(ratingView.rating,68)
    XCTAssertEqual(ratingView.scoreColor,.brand_yellow)
  }
  
  func testOrangeColor() throws {
    let ratingView = RatingText(vote_average: "5.1")
    XCTAssertEqual(ratingView.rating,51)
    XCTAssertEqual(ratingView.scoreColor,.brand_orange)
  }
  
  func testRedColor() throws {
    let ratingView = RatingText(vote_average: "3.6")
    XCTAssertEqual(ratingView.rating,36)
    XCTAssertEqual(ratingView.scoreColor,.brand_red)
  }

}
