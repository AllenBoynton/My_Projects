//
//  FinalScoreVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 6/10/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import Foundation
import UIKit
import GameKit

class FinalScoreVC: UIViewController {
    
    let pokeMatchVC = PokeMatchVC()
    
    @IBOutlet weak var finalGameTime: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    // Time passed from PokeMatchVC
    var timePassed = ""
    
    var score = Int()
    
    // AdMob variables

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign value to labels after checking for nil
        if !timePassed.isEmpty {
            finalGameTime.text = timePassed
        } else {
            finalGameTime.text = "0"
        }
        
        // Call interstitial ad function
    }
    
    // Interstitial ad allocation
    
    // Seperate string out to numbers
    func convertStringToNumbers() -> Int64 {
        let strToInt64 = timePassed.westernArabicNumeralsOnly
        print("Converted score: \(strToInt64)")
        return Int64(strToInt64)!
    }
    
    // Reporting game time
    func saveHighScore(_ score: Int) {
        // if player is logged in to GC, then report the score
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            // Save game time to GC
            let scoreReporter = GKScore(leaderboardIdentifier: timeLeaderboardID)
            scoreReporter.value = Int64(score)
            
            let gkScoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
            })
        }
        
        // Send score to HighScoreVC
        if !timePassed.isEmpty {
            let highScoreVC = HighScoreVC()
            highScoreVC.score = Int(score)
            
            self.present(highScoreVC, animated: true, completion: nil)
        }
    }
    
    // Restart game button to main menu
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        saveHighScore(Int(convertStringToNumbers()))
        print("GC Time: \(Int(convertStringToNumbers()))")
        
        pokeMatchVC.setupNewGame()
        
        // Return to game screen
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchVC")
        self.show(vc!, sender: self)
    }
}
