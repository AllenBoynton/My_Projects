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
import UserNotifications
import GameKit

// Global Identifier
let cellId = "PokeCell"

// Global references
var bgMusic:   AVAudioPlayer?
var cheering: AVAudioPlayer!
var patSound: AVAudioPlayer!
var gameOver: AVAudioPlayer!

class PokeMatchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MemoryGameDelegate {
    
    let gameController = PokeMemoryGame()
    
    // Collection view to hold all images
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imagePassed: UIImageView!
    
    // Outlet for game display
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Outlets for views
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    
    // MARK - Local variables
    
    // Images passed from OptionsVC
    var theImagePassed = UIImage()
    
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
        
        // Game delegate
        gameController.delegate = self
        
        // Methods contained to reset game
        if gameController.isPlaying {
            resetGame()
        }
        
        imagePassed.image = theImagePassed
    }
    
    // MARK: Sound files
    func playCheering() {
        // Cheering audio
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "cheering", ofType: "mp3")!)
        
        do {
            cheering = try AVAudioPlayer(contentsOf: url)
            cheering.prepareToPlay()
            cheering.play()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    // Sound file
    func playPatSound() {
        // Pat audio
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: "pat", ofType: "mp3")!)
        
        do {
            patSound = try AVAudioPlayer(contentsOf: url)
            patSound.prepareToPlay()
            patSound.play()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
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
        
        startButton.isHidden = false
        startButton.isEnabled = true
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
        playPatSound()
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
        playCheering()
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "FinalScoreVC") as! FinalScoreVC
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
    
    
    // MARK: Notification function
    
    func showNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ())  {
        // Add an attachment
        let logoImage = "tenor1"
        guard let imageURL = Bundle.main.url(forResource: logoImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        
        // Create timer for notification to alert once app is exited
        let notification = UNMutableNotificationContent()
        
        notification.title = "New PokéMatch Notification"
        notification.subtitle = "Come back to PokéMatch?"
        notification.body = "Tap here to finish your game!"
        notification.badge = 1
        
        notification.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "gameOver", content: notification, trigger: trigger)
        
        // Add to Notification Center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if error != nil {
                print(error.debugDescription)
                completion(false)
            } else {
                completion(true)
            }
        })        
    }
    
    
    // MARK - IBAction functions
    
    @IBAction func startButton(_ sender: UIButton) {
        // Begin with new setup
        setupNewGame()
        
        // Shows button at beginning of game
        startButton.isHidden = true
        startButton.isEnabled = false
        
        // Unhides views after start button is pressed
        collectionView.isHidden = false
        bottomView.isHidden = false
    }
    
    // Go forward to Best Times
    @IBAction func goToBestTimes(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HighScoreVC") as! HighScoreVC
        self.present(vc, animated: true, completion: nil)
    }
    
    // Back button to bring to main menu
    @IBAction func backButtonPressed(_ sender: Any) {
        showNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
        
        timer?.invalidate()
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC
        self.present(myVC, animated: true, completion: nil)
    }
}
