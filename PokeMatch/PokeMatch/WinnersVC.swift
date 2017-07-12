//
//  WinnersVC.swift
//  PokéMatch
//
//  Created by Allen Boynton on 6/10/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit
import GameKit

class WinnersVC: UIViewController {
    
    let pokeMatchVC = PokeMatchVC()
    
    @IBOutlet weak var finalGamePoints: UILabel!
    @IBOutlet weak var finalGameTime: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    
    
    // Scores passed from PokeMatchVC
    var pointsPassed = ""
    var timePassed = ""
    
    // Bool whether restart button is visible/hidden
    var restartShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Assign value to labels
        finalGamePoints.text = pointsPassed
        finalGameTime.text = timePassed
        
//        // Sound for game over reached
//        func startGameMusic() {
//            
//            let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "gameover", ofType: "mp3")!)
//            
//            do {
//                gameOver = try AVAudioPlayer(contentsOf: url)
//                gameOver.prepareToPlay()
//                gameOver?.play()
//                gameOver?.numberOfLoops = 1
//            } catch let error as NSError {
//                print("audioPlayer error \(error.localizedDescription)")
//            }
//        }
    }
    
    // Set gesture tap to show reset button when screen is tapped
    @IBAction func tapScreenToRestart(_ sender: UIButton) {
        if restartShowing {
            UIView.animate(withDuration: 0.7, animations: {
                self.backgroundButton.alpha = 0.6
                self.resetButton.alpha = 1
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.7, animations: {
                self.backgroundButton.alpha = 0.01
                self.resetButton.alpha = 0
                self.view.layoutIfNeeded()
            })
        }
        
        // Allows toggle
        restartShowing = !restartShowing
    }
    
    // Reset game button to main menu
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        pokeMatchVC.resetGame()
        dismiss(animated: true, completion: nil)
//        navigationController?.popToRootViewController(animated:true)
    }
}
