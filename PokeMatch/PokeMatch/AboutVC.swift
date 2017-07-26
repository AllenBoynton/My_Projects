//
//  AboutVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 7/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class AboutVC: UIViewController {
    
    // Clas delegates
    let finalScoreVC = FinalScoreVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // Continue the game after GameCenter is closed
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // Button brings you to GC leaderboard
    @IBAction func gcLeaderboardBtn(_ sender: UIButton) {
        finalScoreVC.saveBestTime(Int64(0))
    }
    
    // Dismiss VC
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
