//
//  DateFormatterTests.swift
//  MovieDB-VIPERTests
//
//  Created by Conrado Mateu on 16/12/20.
//

import XCTest
@testable import MovieDB_VIPER

import Combine
import SwiftUI

class DateFormatterTests: XCTestCase {

    func testXXICenturyDateFormatter() throws {
      let yearFormatted = Formatter.releaseYear(from: "2018-12-05")
      XCTAssertEqual(yearFormatted,"2018")
    }
  
  func testXXCenturyDateFormatter() throws {
    let yearFormatted = Formatter.releaseYear(from: "1996-10-03")
    XCTAssertEqual(yearFormatted,"1996")
  }

}
