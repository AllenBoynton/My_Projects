//
//  PokeMatchViewController.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/22/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//  Image Source: © Pokémon
//

import UIKit

// Global Identifier
let cellId = "PokeCell"

class PokeMatchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MemoryGameDelegate {
    
    var gameController = PokeMemoryGame()
    var notifications = Notifications()
    
    // Collection view to hold all images
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Outlet for game display
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Outlets for views
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK - Local variables
    
    // Time passed to FinalScoreVC
    var gameTimePassed = UILabel()
    
    // Deducts images until we reach 0 and the user wins
    var gameOver = Bool()
    
    // NSTimers for game time and delays in revealed images
    var timer: Timer?
    var timer1 = Timer(), timer2 = Timer(), timer3 = Timer()
    
    // Time values instantiated
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var display: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Methods contained to reset game
        if gameController.isPlaying {
            resetGame()
        }
    }
    
    // Updates game time on displays
    func startGameTimer() -> String {
        // Calculate total time since timer started in seconds
        time = gameController.elapsedTime
        
        // Calculate minutes
        let minutes = UInt32(time / 60.0)
        time -= (TimeInterval(minutes) * 60)
        
        // Calculate seconds
        let seconds = UInt32(time)
        time -= TimeInterval(seconds)
        
        // Calculate milliseconds
        let milliseconds = UInt32(time * 100)
        
        // Format time vars with leading zero
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        // Add time vars to relevant labels
        display = String(format: "\(strMinutes):\(strSeconds).\(strMilliseconds)", NSLocalizedString("", comment: ""), gameController.elapsedTime)
        
        // Display game time counter
        timerDisplay.text = display
        
        return display
    }
    
    // Sets up for new game
    func setupNewGame() {
        let cardsData: [UIImage] = PokeMemoryGame.defaultCardImages
        gameController.newGame(cardsData)
    }
    
    // Created to reset game. Resets points, time and start button.
    func resetGame() {
        gameController.stopGame()
        if timer?.isValid == true {
            timer?.invalidate()
        }
        collectionView.isUserInteractionEnabled = true
        collectionView.reloadData()
        
        playButton.isHidden = false
        playButton.isEnabled = true
    }
    
    // MARK: - MemoryGameDelegate
    
    func memoryGameDidStart(_ game: PokeMemoryGame) {
        collectionView.reloadData()
        collectionView.isUserInteractionEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
    }
    
    // Function for cards that are being shown
    func memoryGame(_ game: PokeMemoryGame, showCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! PokeVCell
            cell.showCard(true, animated: true)
        }
    }
    
    // Function for cards that are being hidden
    func memoryGame(_ game: PokeMemoryGame, hideCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! PokeVCell
            cell.showCard(false, animated: true)
        }
    }
    
    // End of game methods
    func memoryGameDidEnd(_ game: PokeMemoryGame, elapsedTime: TimeInterval) {
        timer?.invalidate()
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "HighScoreViewController") as! HighScoreViewController
        myVC.timePassed = self.display
        self.present(myVC, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource
    
    // Determines which device the user has - determines # of cards
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if DeviceType.IS_IPHONE {
            return gameController.numberOfCards > 0 ? gameController.numberOfCards: 20
        } else if DeviceType.IS_IPAD {
            return gameController.numberOfCards > 0 ? gameController.numberOfCards: 30
        } else if DeviceType.UNSPECIFIED {
            return gameController.numberOfCards > 0 ? gameController.numberOfCards: 20
        } else {
            return gameController.numberOfCards > 0 ? gameController.numberOfCards: 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PokeVCell
        cell.showCard(false, animated: false)
        
        guard let card = gameController.cardAtIndex(indexPath.item) else { return cell }
        cell.card = card
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PokeVCell
        
        if cell.shown { return }
        gameController.didSelectCard(cell.card)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Card tapped")
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat!
        if DeviceType.IS_IPHONE {
            itemWidth = collectionView.frame.width / 4.0 - 10.0 // 4 wide
            return CGSize(width: itemWidth, height: itemWidth + 15)
        } else {//if DeviceType.IS_IPAD {
            itemWidth = collectionView.frame.width / 5.0 - 8.0 // 5 wide
            return CGSize(width: itemWidth, height: itemWidth + 15)
        }
    }
    
    // MARK - IBAction functions
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        // Begin with new setup
        setupNewGame()
        
        // Shows button at beginning of game
        playButton.isHidden = true
        playButton.isEnabled = false
        
        // Unhides views after start button is pressed
        collectionView.isHidden = false
        bottomView.isHidden = false
        collectionView.allowsSelection = true
    }
    
    // Back button to bring to main menu
    @IBAction func backButtonTapped(_ sender: Any) {
        notifications.showNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
        
        timer?.invalidate()
        
        dismiss(animated: true, completion: nil)
//        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
//        self.show(myVC, sender: self)
    }
}
