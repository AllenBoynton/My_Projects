//
//  AboutViewController.swift
//  PokéMatch
//
//  Created by Allen Boynton on 7/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class AboutViewController: UIViewController, GKGameCenterControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        let gameCenterViewController = GKGameCenterViewController()
        
        gameCenterViewController.gameCenterDelegate = self
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = timeLeaderboardID
        
        // Show leaderboard
        self.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Adds the Done button to the GC view controller
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // Button brings you to GC leaderboard
    @IBAction func gcLeaderboardBtn(_ sender: UIButton) {
        showLeaderboard()
    }
    
    // Dismiss VC
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
