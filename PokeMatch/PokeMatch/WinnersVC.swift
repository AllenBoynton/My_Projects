//
//  WinnersVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 6/10/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit
import GoogleMobileAds

var interstitial: DFPInterstitial?

class WinnersVC: UIViewController, UIAlertViewDelegate {
    
    let pokeMatchVC = PokeMatchVC()
    
    @IBOutlet weak var finalGamePoints: UILabel!
    @IBOutlet weak var finalGameTime: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    
    // Scores passed from PokeMatchVC
    var scorePassed = ""
    var timePassed = ""
    
    // GC score variables
    var score: Int64!
    var time: Int64!
    
    // Bool whether restart button is visible/hidden
    var restartShowing = true
    
    // AdMob variables
    var interstitial: DFPInterstitial?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign value to labels
        finalGamePoints.text = scorePassed
        finalGameTime.text = timePassed
        
        // Call interstitial ad function
        interstitial = createAndLoadInterstitial() as? DFPInterstitial
    }
    
    // Interstitial ad allocation
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712") as? DFPInterstitial
            //"ca-app-pub-2292175261120907/5861239922") as? DFPInterstitial
        interstitial?.delegate = self as? GADInterstitialDelegate
        
        let request = GADRequest()
        interstitial?.load(request)
        request.testDevices = [ kGADSimulatorID,   // All simulators
            "7ed9d992b26e0010d4bee7686ba6b7e30224852b" ]  // iPad device ID
        
        return interstitial!
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial() as? DFPInterstitial
    }
    
    // Reporting score
    func saveHighScore(_ score: Int64) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            // Save game points to GC
            let gkScore = GKScore(leaderboardIdentifier: pointsLeaderboardID)
            gkScore.value = score
            
            let gkScoreArray: [GKScore] = [gkScore]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
                
                let vc = GKGameCenterViewController()
                vc.leaderboardIdentifier = pointsLeaderboardID
                vc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
                vc.viewState = .leaderboards
                
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    // score = 2 * 60 + 22
    
    // Reporting game time
    func saveBestTime(_ time: Int64) {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            // Save game time to GC
            let gkScore = GKScore(leaderboardIdentifier: timeLeaderboardID)
            gkScore.value = time
            
            let gkScoreArray: [GKScore] = [gkScore]
            
            GKScore.report(gkScoreArray, withCompletionHandler: { error in
                guard error == nil  else { return }
                
                let vc = GKGameCenterViewController()
                vc.leaderboardIdentifier = pointsLeaderboardID
                vc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
                vc.viewState = .leaderboards
                
                self.present(vc, animated: true, completion: nil)
            })
        }
    }
    
    // Set gesture tap to show reset button when screen is tapped
    @IBAction func handleScreenTap(_ sender: UITapGestureRecognizer) {
        if restartShowing {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.restartShowing = true
                self.backgroundButton.alpha = 0.6
                self.resetButton.isHidden = false
                self.resetButton.alpha = 1
                self.view.layoutIfNeeded()
            })
//            UIView.animate(withDuration: 0.7, animations: {
//                self.backgroundButton.alpha = 0.6
//                self.resetButton.alpha = 1
//                self.view.layoutIfNeeded()
//            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.restartShowing = false
                self.backgroundButton.alpha = 0
                self.resetButton.isHidden = true
                self.resetButton.alpha = 0
                self.view.layoutIfNeeded()
            })
//            UIView.animate(withDuration: 0.7, animations: {
//                self.backgroundButton.alpha = 0.01
//                self.resetButton.alpha = 0
//                self.view.layoutIfNeeded()
//            })
        }
        
        // Allows toggle
        restartShowing = !restartShowing
    }
    
    // Reset game button to main menu
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        saveHighScore(score)
        saveBestTime(time)
        print("\(time)")
        
        // Call ad
        if (interstitial?.isReady)! {
            interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
        // Call resetGame function to restart from the beginning
        pokeMatchVC.resetGame()
//        dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated:true)
    }
}
