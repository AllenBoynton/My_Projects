//
//  MovieManagerTests.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/9/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import XCTest

@testable import FilmFest
class MovieManagerTests: XCTestCase {
    
    var sut: MovieManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MovieManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoviesToSeeCount_ReturnsZero() {
        XCTAssertEqual(sut.moviesToSeeCount, 0)
    }
    
    func testMoviesSeen_ReturnsZero() {
        XCTAssertEqual(sut.moviesSeenCount, 0)
    }
    
    func testMoviesToSeeCount_ShouldBeOneAfterMovieAdded() {
        sut.addMovieToLibrary(movie: Movie(title: "Sci-Fi Adventure"))
        XCTAssertEqual(sut.moviesToSeeCount, 1)
    }
    
    func testMovieAtIndex_ReturnsLastAddedMovie() {
        let movie = Movie(title: "Action Thriller")
        sut.addMovieToLibrary(movie: movie)
        
        let returnedMovieAtIndex = sut.movieAtIndex(index: 0)
        XCTAssertEqual(movie.title, returnedMovieAtIndex.title)
    }
}
