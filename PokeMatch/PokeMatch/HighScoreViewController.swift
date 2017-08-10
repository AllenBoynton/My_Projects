//
//  HighScoreViewController.swift
//  PokéMatch
//
//  Created by Allen Boynton on 8/1/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class HighScoreViewController: UIViewController {
    
    var pokeMatchViewController = PokeMatchViewController()
    var gameCenter = GameCenter()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentHighScore: UILabel!
    
    var score = Int()
    var highScore = Int()
    
    var minutes: Int!
    var seconds: Int!
    var millis: Int!
    
    var scoreString: String!
    var highScoreString: String!
    
    // Time passed from PokeMatchVC
    var timePassed = ""
    var strToInt64: String?
        
    // AdMob variables
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign value to labels after checking for nil
        if !timePassed.isEmpty {
            scoreLabel.text = timePassed
        } else {
            scoreLabel.text = "0"
        }
        
        // Call interstitial ad function
        
        
        print("Score: \(score)")
        checkHighScoreForNil()
        addScore()
    }
    
    // Interstitial ad allocation
    
    
    // Verifies score/time is not nil
    func checkHighScoreForNil() {
        let highScoreDefault = UserDefaults.standard
        
        if highScoreDefault.value(forKey: "HighScore") != nil {
            highScore = score
            highScore = highScoreDefault.value(forKey: "HighScore") as! NSInteger
            
            currentHighScore.text = intToHighScoreString(score: highScore)
        }
    }
    
    func intToScoreString(score: Int) ->String {
        minutes = score / 10000
        seconds = (score / 100) % 100
        millis = score % 100
        
        scoreString = NSString(format: "Time: %i:%02i.%02i", minutes, seconds, millis) as String
        return scoreString
    }
    
    func intToHighScoreString(score: Int) ->String {
        minutes = score / 10000
        seconds = (score / 100) % 100
        millis = score % 100
        
        highScoreString = NSString(format: "Best Time: %i:%02i.%02i", minutes, seconds, millis) as String
        return highScoreString
    }
    
    // Adds time from game to high scores. Compares again others for order
    func addScore() {
        scoreLabel.text = "Returned: \(intToScoreString(score: score))"
        if (score > highScore) {
            highScore = score            
            currentHighScore.text = "Returned High: \(intToHighScoreString(score: highScore))"
            
            handleHighScoreReset()
        }
    }
    
    // Handles the saving of high score as cumulative or reset to 0
    func handleHighScoreReset() {
        let highScoreDefault = UserDefaults.standard
        highScoreDefault.set(highScore, forKey: "HighScore")
        highScoreDefault.synchronize()
    }
    
    // Seperate string out to numbers
    func convertStringToNumbers() -> Int64 {
        let strToInt64 = timePassed.westernArabicNumeralsOnly
        print("Converted score: \(strToInt64)")
        return Int64(strToInt64)!
    }
    
    // Play again game button to main menu
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        gameCenter.saveHighScore(Int(convertStringToNumbers()))
        print("GC Time: \(Int(convertStringToNumbers()))")
        
        pokeMatchViewController.setupNewGame()
        
        // Return to game screen
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchViewController")
        self.show(vc!, sender: self)
    }
    
    // Resets score/time and high score back to 0
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        score = 0
        highScore = 0
        
        scoreLabel.text = NSString(format: "Time: %i", score) as String
        currentHighScore.text = NSString(format: "Best Time: %i", highScore) as String
        
        handleHighScoreReset()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        pokeMatchViewController.setupNewGame()

        dismiss(animated: true, completion: nil)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController")
//        self.show(vc!, sender: self)
    }
}
