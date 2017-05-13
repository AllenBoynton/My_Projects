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
    
    func testFavoriteMovies_UpdatesMoviesSeenAndMoviesToSeeCounts() {
        sut.addMovieToLibrary(movie: Movie(title: "Action Adventure"))
        sut.favoriteMovieAtIndex(index: 0)
        
        XCTAssertEqual(sut.moviesToSeeCount, 0)
        XCTAssertEqual(sut.moviesSeenCount, 1)
    }
    
    func testFavoriteMovie_ShouldRemoveMovieFromMoviesToSeeArray() {
        let movie1 = Movie(title: "Action Adventure")
        let movie2 = Movie(title: "Biography")
        
        sut.addMovieToLibrary(movie: movie1)
        sut.addMovieToLibrary(movie: movie2)
        sut.favoriteMovieAtIndex(index: 0)
        
        XCTAssertEqual(sut.movieAtIndex(index: 0).title, movie2.title)
    }
    
    func testFavoriteMovieAtIndex_ShouldReturnFavoritedMovie() {
        let movie = Movie(title: "Thriller")
        sut.addMovieToLibrary(movie: movie)
        sut.favoriteMovieAtIndex(index: 0)
        let returnedMovie = sut.favoritedMovieAtIndex(index: 0)
        
        XCTAssertEqual(movie.title, returnedMovie.title)
    }
    
    func testClearAllArrayItems_ShouldReturnArrayCountsOfZero() {
        sut.addMovieToLibrary(movie: Movie(title: "Thriller"))
        sut.addMovieToLibrary(movie: Movie(title: "Action"))
        sut.favoriteMovieAtIndex(index: 0)
        
        XCTAssertEqual(sut.moviesToSeeCount, 1)
        XCTAssertEqual(sut.moviesSeenCount, 1)
        
        sut.clearArrays()
        
        XCTAssertEqual(sut.moviesToSeeCount, 0)
        XCTAssertEqual(sut.moviesSeenCount, 0)
    }
    
    
}
