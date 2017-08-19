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
    
    var mainMenuViewController = MainMenuViewController()
    var pokeMatchViewController = PokeMatchViewController()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScore1Lbl: UILabel!
    @IBOutlet weak var highScore2Lbl: UILabel!
    @IBOutlet weak var highScore3Lbl: UILabel!
    @IBOutlet weak var highScore4Lbl: UILabel!
    @IBOutlet weak var highScore5Lbl: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    lazy var score = Int()
    lazy var highScore1 = Int()
    lazy var highScore2 = Int()
    lazy var highScore3 = Int()
    lazy var highScore4 = Int()
    lazy var highScore5 = Int()
    
    lazy var minutes = Int()
    lazy var seconds = Int()
    lazy var millis = Int()
    
    // Time passed from PokeMatchVC
    var timePassed: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showItems()
        checkHighScoreForNil()
        addScore()
    }
    
    // Interstitial ad allocation
    
    
    // Shows items depending on best score screen or final score screen
    func showItems() {
        playAgainButton.isHidden = false
        menuButton.isHidden = false
    }

    // Verifies score/time is not nil
    func checkHighScoreForNil() {
        let highScoreDefault = UserDefaults.standard
        
        if highScoreDefault.value(forKey: "HighScore") != nil {
            highScore1 = highScoreDefault.value(forKey: "HighScore") as! NSInteger
            highScore1Lbl.text = "\(intToScoreString(score: highScore1))"
        }
    }
    
    // Score format for time
    func intToScoreString(score: Int) -> String {
        minutes = score / 10000
        seconds = (score / 100) % 100
        millis = score % 100
        
        let scoreString = NSString(format: "%02i:%02i.%02i", minutes, seconds, millis) as String
        return scoreString
    }
    
//    // Score format for best time
//    func intToHighScoreString(score: Int) -> String {
//        minutes = score / 10000
//        seconds = (score / 100) % 100
//        millis = score % 100
//        
//        let highScoreString = NSString(format: "%02i:%02i.%02i", minutes, seconds, millis) as String
//        return highScoreString
//    }
    
    // Adds time from game to high scores. Compares again others for order
    func addScore() {
        if timePassed != nil {
            menuButton.isHidden = true
            score = Int(convertStringToNumbers(time: timePassed!)!)
            scoreLabel.text = "\(intToScoreString(score: score))"
            if (score < highScore1) {
                highScore1 = score
                highScore1Lbl.text = "\(intToScoreString(score: Int(highScore1)))"
                
                handleHighScoreReset()
            }
        } else {
            scoreLabel.isHidden = true
            playAgainButton.isHidden = true
            print("timePassed = nil")
        }
    }
    
    // Handles the saving of high score as cumulative or reset to 0
    func handleHighScoreReset() {
        let highScoreDefault = UserDefaults.standard
        highScoreDefault.set(highScore1, forKey: "HighScore")
        highScoreDefault.synchronize()
    }
    
    // Seperate string out to numbers
    func convertStringToNumbers(time: String) -> Int? {
        let strToInt = time.westernArabicNumeralsOnly
        return Int(strToInt)!
    }
    
    // Play again game button to main menu
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        if timePassed != nil {
            mainMenuViewController.saveHighScore(Int64(convertStringToNumbers(time: timePassed!)!))
            print("GC Time: \(String(describing: convertStringToNumbers(time: timePassed!)!))")
        }
        
        pokeMatchViewController.setupNewGame()
        
        // Return to game screen
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchViewController")
        self.show(vc!, sender: self)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        pokeMatchViewController.setupNewGame()

        let vc = self.storyboard?.instantiateInitialViewController()
        self.show(vc!, sender: self)
    }
}
