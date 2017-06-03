//
//  PokeMatchVC.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/22/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//  Image Source: © Pokémon
//

import UIKit
import AVFoundation
import GameKit

// Protocol to inform the delegate GameVC if a game is over
protocol GameSceneDelegate {
    func showLeaderboard()
    func reportScore(_ score: Int64)
}

// Global references
var bgMusic:   AVAudioPlayer?
var cheering:  AVAudioPlayer?
var tadaSound: AVAudioPlayer?
var patSound:  AVAudioPlayer?
var chime:     AVAudioPlayer?
var wrong:     AVAudioPlayer?

let cellIdentifier = "PokeCell"

class PokeMatchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { //, MemoryGameDelegate {
    
    // Collection view to hold all images
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bgImageView: UIImageView!
    
    // Outlet for game displays
    @IBOutlet weak var pointsDisplay: UILabel!
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Outlets for views
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    
    let gameController = PokeMemoryGame()
    
    // MARK - Local variables
    
    // Images passed from OptionsVC
    var theImagePassed = UIImage()
    
    // Deducts images until we reach 0 and the user wins
    var tileCounter = 0
    var gamePoints = 0
    
    // NSTimers for game time and delays in revealed images
    var timer: Timer?
    var timer1 = Timer(), timer2 = Timer(), timer3 = Timer()
    
    // Time values instantiated
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var display: String = ""
    var gameOver = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Passing image from OptionsVC
        bgImageView.image = theImagePassed

        // Game delegate
//        gameController.delegate = self
        
        // Methods contained to reset game
        resetGame()
    }
    
    // Sound files
    func prepareAudios() {
        // Cheering audio
        let url1 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "cheering", ofType: "mp3")!)
        
        do {
            cheering? = try AVAudioPlayer(contentsOf: url1)
            cheering?.delegate = self as? AVAudioPlayerDelegate
            cheering?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
        
        // TaDa audio
        let url2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "taDa", ofType: "mp3")!)
        
        do {
            tadaSound? = try AVAudioPlayer(contentsOf: url2)
            tadaSound?.delegate = self as? AVAudioPlayerDelegate
            tadaSound?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
        
        // Chime audio
        let url3 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "chime", ofType: "mp3")!)
        
        do {
            chime? = try AVAudioPlayer(contentsOf: url3)
            chime?.delegate = self as? AVAudioPlayerDelegate
            chime?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
        
        // Pat audio
        let url4 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "pat", ofType: "mp3")!)
        
        do {
            patSound? = try AVAudioPlayer(contentsOf: url4)
            patSound?.delegate = self as? AVAudioPlayerDelegate
            patSound?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    // Create function to initiate music playing when game begins
    func startGameMusic() {
        
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
        
        do {
            bgMusic? = try AVAudioPlayer(contentsOf: url)
            bgMusic?.delegate = self as? AVAudioPlayerDelegate
            bgMusic?.prepareToPlay()
            bgMusic?.play()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    // Starts time when play button is pressed.
//    func startGameTime() {
//        
//        startTime = Date().timeIntervalSinceReferenceDate - elapsed
//        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//    }
//    
//    // Updates game time on displays
//    @objc func updateCounter() -> String {
//        
//        collectionView.reloadData()
//        collectionView.isUserInteractionEnabled = true
//        
//        // Calculate total time since timer started in seconds
//        time = Date().timeIntervalSinceReferenceDate - startTime
//        
//        // Calculate minutes
//        let minutes = UInt8(time / 60.0)
//        time -= (TimeInterval(minutes) * 60)
//        
//        // Calculate seconds
//        let seconds = UInt8(time)
//        time -= TimeInterval(seconds)
//        
//        // Calculate milliseconds
//        let milliseconds = UInt8(time * 100)
//        
//        // Format time vars with leading zero
//        let strMinutes = String(format: "%02d", minutes)
//        let strSeconds = String(format: "%02d", seconds)
//        let strMilliseconds = String(format: "%02d", milliseconds)
//        
//        // Add time vars to relevant labels
//        display = "\(strMinutes):\(strSeconds):\(strMilliseconds)"
//        timerDisplay.text = display
//        print(display)
//        
//        return display
//    }
    
    func gameTimerAction() {
        timerDisplay.text = String(format: "%@:%@:%@", NSLocalizedString("", comment: ""), gameController.elapsedTime)
        
        collectionView.reloadData()
        collectionView.isUserInteractionEnabled = true
    }

//    func savePlayerScore(_ name: String, score: TimeInterval) {
//        Highscores.sharedInstance.saveHighscore(name, score: score)
//    }
    
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
            timer = nil
        }
        collectionView.isUserInteractionEnabled = false
        collectionView.reloadData()
        
        
        startButton.isHidden = false
        startButton.isEnabled = true
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameController.numberOfCards > 0 ? gameController.numberOfCards: 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokeVCell
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
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth: CGFloat = collectionView.frame.width / 4.0 - 10.0 // 4 wide
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // MARK: - MemoryGameDelegate
    
//    func memoryGameDidStart(_ game: PokeMemoryGame) {
//        
//        collectionView.reloadData()
//        collectionView.isUserInteractionEnabled = true
//        
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(gameTimerAction), userInfo: nil, repeats: true)
//
//    }
    
    func memoryGame(_ game: PokeMemoryGame, showCards cards: [Card]) {
        gamePoints -= 25
        patSound?.play()
        
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! PokeVCell
            cell.showCard(true, animated: true)
        }
    }
    
    func memoryGame(_ game: PokeMemoryGame, hideCards cards: [Card]) {
        gamePoints += 100
        prepareAudios()
        chime?.play()
        
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! PokeVCell
            cell.showCard(false, animated: true)
        }
    }
    
    func memoryGameDidEnd(_ game: PokeMemoryGame, elapsedTime: TimeInterval) {
        timer?.invalidate()
        
        prepareAudios()
        tadaSound?.play()
        cheering?.play()
        
    }
    
    // MARK - IBAction functions
    
    @IBAction func startButton(_ sender: UIButton) {
        
        // Button sound
        prepareAudios()
        patSound?.play()
        
        // Shows button at beginning of game
        startButton.isHidden = true
        startButton.isEnabled = false
        
        // Unhides views after start button is pressed
        pointsView.isHidden = false
        collectionView.isHidden = false
        bottomView.isHidden = false
        
        collectionView.reloadData()
        collectionView.isUserInteractionEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(gameTimerAction), userInfo: nil, repeats: true)
        
//        if gameController.isPlaying {
//            resetGame()
//            startButton.setTitle(NSLocalizedString("Start", comment: "start"), for: UIControlState())
//        } else {
//            setupNewGame()
//            startButton.setTitle(NSLocalizedString("Stop", comment: "stop"), for: UIControlState())
//        }
    }
    
    // Audio button mutes/unmutes music
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if (bgMusic?.isPlaying)! {
            // pauses music & makes partial transparent
            bgMusic?.pause()
            sender.alpha = 0.2
            
        } else {
            // plays music & makes full view
            bgMusic?.play()
            sender.alpha = 1.0
        }
    }
    
    // Back button to bring to main menu
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        timer?.invalidate()
    }
    
}
