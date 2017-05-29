//
//  MainMenuVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/24/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//  Image Source: © Pokémon Go
//

import UIKit
import AVFoundation
import GameKit

// Global identifiers
let timeLeaderboardID = "BEST_TIME" // Time Leaderboard
let pointsLeaderboardID = "HIGH_POINTS" // Score Leaderboard

// Achievement identifiers
var inc300AchievementID = "300_POINTS" // Incremental 300 point achievement
//        var inc500AchievementID = "500_POINTS" // Incremental 500 point achievement
//        var inc800AchievementID = "800_POINTS" // Incremental 800 point achievement
//        var inc1000AchievementID = "1000_POINTS" // Incremental 1000 point achievement
//        var inc1200AchievementID = "1200_POINTS" // Incremental 1200 point achievement
//        var incMaxAchievementID = "MAX_POINTS" // Incremental 1500 point achievement
var fullProgressID = "MAX_POINTS" // Incremental Max point achievement

class MainMenuVC: UIViewController {
    
    // Class delegates
    var pokeMatchVC: PokeMatchVC!
//    var gameKitHelper: GameKitHelper!
    
    // Create AV player
    var musicPlayer: AVAudioPlayer!
    
    // The local player object.
    let localPlayer = GKLocalPlayer.localPlayer()
    
    // Local GC variables
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    var score = 0
    
    // Game Center Achievement properties
    var achievementIdentifier: String?
    var progressPercentage: Int64 = 0
    var progressInLevelAchievement: Bool?
    var levelAchievement: GKAchievement?
    var scoreAchievement: GKAchievement?
    var powerUpAchievement: GKAchievement?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticatePlayer()
        startGameMusic()
    }
    
    // Authenticates the user to access to the GC
    func authenticatePlayer() {
        
        localPlayer.authenticateHandler = {(view, error) -> Void in
            if((view) != nil) {
                
                // 1. Show login if player is not logged in
                self.present(view!, animated: true, completion: nil)
               
                NotificationCenter.default.addObserver(
                    self, selector: #selector(self.authenticationDidChange(_:)),
                    name: NSNotification.Name(rawValue: GKPlayerAuthenticationDidChangeNotificationName),
                    object: nil)
                
            } else if (self.localPlayer.isAuthenticated) {
                
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                self.localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifier, error) in
                    if error != nil {
                        
                        print(error as Any)
                    } else {
                        
                        self.gcDefaultLeaderBoard = leaderboardIdentifier!
                    }
                })
                
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error as Any)
            }
        }
    }
    
    func notificationReceived() {
        print("GKPlayerAuthenticationDidChangeNotificationName - Authentication Status: \(localPlayer.isAuthenticated)")
    }
    
    // Reporting score
    func saveHighScore(_ score: Int64) {
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let gkScore = GKScore(leaderboardIdentifier: pointsLeaderboardID)
            gkScore.value = score
            
            let gkScoreArray: [GKScore] = [gkScore]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
                
                let vc = GKGameCenterViewController()
                vc.leaderboardIdentifier = pointsLeaderboardID
                vc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
                vc.viewState = .leaderboards
                
                self.present(vc, animated: true, completion: nil)   })
        }
    }
    
    // Report example score after user logs in
    func authenticationDidChange(_ notification: Notification) {
        saveHighScore(0)
    }
    
    // Retrieves the GC VC leaderboard
    func showLeaderboard() {
        
        let viewController = self.view.window?.rootViewController
        
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self as? GKGameCenterControllerDelegate
        gameCenterViewController.viewState = .leaderboards
        gameCenterViewController.leaderboardIdentifier = pointsLeaderboardID
        
        // Show leaderboard
        viewController?.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Create function to initiate music playing when game begins
    func startGameMusic() {
        
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
        
        do {
            try bgMusic = AVAudioPlayer(contentsOf: url)
            bgMusic?.delegate = self as? AVAudioPlayerDelegate
            bgMusic?.prepareToPlay()
            bgMusic?.play()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    // IBActions for main menu buttons
    @IBAction func singlePlayerBtnPressed(_ sender: Any) {
        
//        bgMusic?.pause()
    }
    
    
    
    // Open Game Center Leaderboard
    @IBAction func checkGCLeaderboard(_ sender: AnyObject) {
        
        // Add points to current score
        score += 300
        
        saveHighScore(Int64(score))
        showLeaderboard()
//        updateAchievements()
    }
    
    // Achievements
//    func updateAchievements() {
//        
//        // Incremental achievement ************************************************************
//        if score <= 300 {
//            
//            let achievement300 = GKAchievement(identifier: inc300AchievementID)
//            
//            achievement300.percentComplete = Double(score / 1500)
//            achievement300.showsCompletionBanner = true  // use Game Center's UI
//            
//            GKAchievement.report([achievement300], withCompletionHandler: nil)
//        }
//        
//        if score <= 300 {
//            inc300AchievementID = "300_POINTS" // Incremental 300 point achievement
//            
//            progressPercentage = Int64(score * 1500 / 300)
//            achievementIdentifier = inc300AchievementID
//        }
//        else if score <= 500 {
//            inc500AchievementID = "500_POINTS" // Incremental 500 point achievement
//            
//            progressPercentage = Int64(score * 1500 / 500)
//            achievementIdentifier = inc500AchievementID
//        }
//        else if score <= 800 {
//            inc800AchievementID = "800_POINTS" // Incremental 800 point achievement
//            
//            progressPercentage = Int64(score * 1500 / 800)
//            achievementIdentifier = inc800AchievementID
//        }
//        else if score <= 1000 {
//            inc1000AchievementID = "1000_POINTS" // Incremental 1000 point achievement
//            
//            progressPercentage = Int64(score * 1500 / 1000)
//            achievementIdentifier = inc1000AchievementID
//        }
//        else if score <= 1200 {
//            inc1200AchievementID = "1200_POINTS" // Incremental 1200 point achievement
//            
//            progressPercentage = Int64(score * 1500 / 1200)
//            achievementIdentifier = inc1200AchievementID
//        }
//        else if score <= 1500 {
//            incMaxAchievementID = "MAX_POINTS" // Incremental 1500 point achievement
//            
//            progressPercentage = Int64(score * 1500 / 1500)
//            achievementIdentifier = incMaxAchievementID
//        }
//        do {
//            fullProgressID = "MAX_POINTS" // Incremental Max point achievement
//            
//            progressPercentage = Int64(score * 1500 / 1500)
//            achievementIdentifier = fullProgressID
//        }
//        scoreAchievement = GKAchievement(identifier: achievementIdentifier)
//        scoreAchievement?.percentComplete = Double(progressPercentage)
//        
//        // Load the user's current achievement progress anytime
//        GKAchievement.loadAchievements() { achievements, error in
//            guard let achievements = achievements else { return }
//            
//            print(achievements)
//        }
//    }

    
    // Continue the game after GameCenter is closed
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        
        gameCenterViewController.dismiss(animated: true, completion: nil)        
    }
}
