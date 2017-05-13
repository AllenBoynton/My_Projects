//
//  MovieManager.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/9/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import Foundation


class MovieManager {
    var moviesToSeeCount: Int { return moviesToSeeArray.count}
    var moviesSeenCount: Int { return moviesSeenArray.count}
    
    private var moviesToSeeArray = [Movie]()
    private var moviesSeenArray = [Movie]()
    
    func addMovieToLibrary(movie: Movie) {
        moviesToSeeArray.append(movie)
    }
    
    func movieAtIndex(index: Int) -> Movie {
        return moviesToSeeArray[index]
    }
    
    func favoriteMovieAtIndex(index: Int) {
        guard index < moviesToSeeCount else {
            return
        }
        
        moviesToSeeArray.remove(at: index)
    }
    
    func favoritedMovieAtIndex(index: Int) -> Movie {
        return moviesToSeeArray[index]
    }
    
    func clearArrays() {
        moviesToSeeArray.removeAll()
        moviesSeenArray.removeAll()
    }
}
