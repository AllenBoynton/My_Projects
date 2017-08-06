//
//  HighScoreVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 8/1/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class HighScoreVC: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentHighScore: UILabel!
    
    var score = Int()
    var highScore = Int()
    
    var minutes: Int!
    var seconds: Int!
    var millis: Int!
    
    var scoreString: String!
    var highScoreString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Score: \(score)")
        checkHighScoreForNil()
        addScore()
    }
    
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
    
    // Resets score/time and high score back to 0
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        score = 0
        highScore = 0
        
        scoreLabel.text = NSString(format: "Time: %i", score) as String
        currentHighScore.text = NSString(format: "Best Time: %i", highScore) as String
        
        handleHighScoreReset()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
