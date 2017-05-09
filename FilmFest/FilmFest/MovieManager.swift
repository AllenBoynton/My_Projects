//
//  MovieManager.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/9/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import Foundation


class MovieManager {
    var moviesToSeeCount = 0
    let moviesSeenCount = 0
    
    private var moviesToSeeArray = [Movie]()
    
    func addMovieToLibrary(movie: Movie) {
        moviesToSeeCount += 1
        moviesToSeeArray.append(movie)
    }
    
    func movieAtIndex(index: Int) -> Movie {
        return moviesToSeeArray[index]
    }
    
}
