//
//  HighScoreViewController.swift
//  PokéMatch
//
//  Created by Allen Boynton on 8/1/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit
import FBSDKShareKit
import GoogleMobileAds

class HighScoreViewController: UIViewController, GKGameCenterControllerDelegate, GADBannerViewDelegate, GADInterstitialDelegate {
    
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
    @IBOutlet weak var gcIconView: UIView!
    
    @IBOutlet weak var adBannerView: GADBannerView!
    
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
    
    lazy var mute = true
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = createAndLoadInterstitial()
        
        handleAdRequest()
        animateGCIcon()
        showItems()
        checkHighScoreForNil()
        addScore()
        facebookShareButton()
    }
    
    // Ad request
    func handleAdRequest() {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        // Ad setup
        adBannerView.adUnitID = "ca-app-pub-2292175261120907/3388241322"
        adBannerView.rootViewController = self
        adBannerView.delegate = self
        
        adBannerView.load(request)
    }
    
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
    
    // Reporting game time
    func saveHighScore(_ score: Int) {
        // if player is logged in to GC, then report the score
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            // Save game time to GC
            let scoreReporter = GKScore(leaderboardIdentifier: timeLeaderboardID)
            scoreReporter.value = Int64(score)
            print("SaveHighScore: \(score)")
            
            let gkScoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                print("GKScoreArray: \(gkScoreArray)")
                if error != nil {
                    print(error!.localizedDescription)
                    return
                } else {
                    print("Best Time submitted to the Leaderboard!")
                }
            })
        }
    }
    
    // Animate GC image
    func animateGCIcon() {
        UIView.animate(withDuration: 1.5, animations: {
            self.gcIconView.transform = CGAffineTransform(scaleX: 20, y: 20)
            self.gcIconView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.gcIconView.transform = CGAffineTransform.identity
            })
        }
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
    
    // Create and load an Interstitial Ad
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b"]
        interstitial.load(request)
        
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        
        if !(bgMusic?.isPlaying)! {
            // plays music & makes full view
            bgMusic?.play()
            print("Audio playing")
        }
    }
    
    @IBAction func showGameCenter(_ sender: UIButton) {
        showLeaderboard()
    }
    
    // Play again game button to main menu
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        if timePassed != nil {
            
            // Interstitial Ad setup
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
                
                // Pause sound if on
                if (bgMusic?.isPlaying)! {
                    // pauses music
                    bgMusic?.pause()
                    print("Audio muted")
                }
            } else {
                print("Ad wasn't ready")
            }
            
            saveHighScore(convertStringToNumbers(time: timePassed!)!)
            print("GC Time: \(convertStringToNumbers(time: timePassed!)!)")
        } else {
            print("Time is nil")
        }
        
        pokeMatchViewController.setupNewGame()
        
        // Return to game screen
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PokeMatchViewController")
        self.show(vc!, sender: self)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        pokeMatchViewController.setupNewGame()
        
        dismiss(animated: true, completion: nil)
    }
    
    // Facebook Share button
    func facebookShareButton() {
        let content = FBSDKShareLinkContent()
        
        content.contentURL = URL(string: "https://www.facebook.com/PokeMatchMobileApp/")
        content.hashtag = FBSDKHashtag(string: "#AlsMobileApps")

        FBSDKShareDialog.show(from: self, with: content, delegate: nil)
        FBSDKMessageDialog.show(with: content, delegate: nil)
        
        let shareButton = FBSDKShareButton()
        shareButton.shareContent = content
        
        shareButton.center = CGPoint(x: view.center.x, y: self.view.frame.height - shareButton.frame.height * 3.0)
        
        view.addSubview(shareButton)
    }
}
