//
//  MovieLibraryViewControllerTests.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/9/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import XCTest

@testable import FilmFest

class MovieLibraryViewControllerTests: XCTestCase {
    
    var sut: MovieLibraryViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieLibraryVC_TableViewShouldNotBeNil() {
        XCTAssertNotEqual(sut.tableView)
    }
    
}
