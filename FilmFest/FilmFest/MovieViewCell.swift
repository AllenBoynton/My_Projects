//
//  MovieViewCell.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/13/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var filmLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    func configureCell(movie: Movie) {
        filmLabel.text = "Gone With The Wind"
        releaseLabel.text = "July 20, 1946"
    }
}
