//
//  MovieLibraryViewController.swift
//  FilmFest
//
//  Created by Allen Boynton on 5/8/17.
//  Copyright © 2017 ABtech Applications. All rights reserved.
//

import UIKit
import ChameleonFramework

// Global identifiers
let movieCell = "MovieCell"

class MovieLibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movie: Movie!
    var movies = [Movie]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = GradientColor(.radial, frame: self.view.frame, colors: [UIColor.flatSkyBlue(), UIColor.flatNavyBlue()])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: movieCell, for: indexPath) as? MovieViewCell {
            let movie = movies[indexPath.row]
            cell.configureCell(movie: movie)
            return cell
        } else {
            return MovieViewCell()
        }
        
        
    }
    
}

