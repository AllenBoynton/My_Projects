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

class PokeMatchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MemoryGameDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Outlet for game displays
    @IBOutlet weak var pointsDisplay: UILabel!
    @IBOutlet weak var timerDisplay: UILabel!
    
    // Outlets for views
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    
    let gameController = PokeMemoryGame()
    
    // MARK - Local variables
    
    // Image array
    var pokeImages: [UIImage] = []
    
    // View array of Images selected
    var selectedImages: [UIView] = []
    
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

        // Game delegate
        gameController.delegate = self
        
        // Methods contained to reset game
        resetGame()
    }
    
    // Sound files
    func prepareAudios() {
        // Cheering audio
        let url1 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "cheering", ofType: "mp3")!)
        
        do {
            try cheering = AVAudioPlayer(contentsOf: url1)
            cheering?.delegate = self as? AVAudioPlayerDelegate
            cheering?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
        
        // TaDa audio
        let url2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "taDa", ofType: "mp3")!)
        
        do {
            try tadaSound = AVAudioPlayer(contentsOf: url2)
            tadaSound?.delegate = self as? AVAudioPlayerDelegate
            tadaSound?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
        
        // Chime audio
        let url3 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "chime", ofType: "mp3")!)
        
        do {
            try chime = AVAudioPlayer(contentsOf: url3)
            chime?.delegate = self as? AVAudioPlayerDelegate
            chime?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
        
        // Pat audio
        let url4 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "pat", ofType: "mp3")!)
        
        do {
            try patSound = AVAudioPlayer(contentsOf: url4)
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
            try bgMusic = AVAudioPlayer(contentsOf: url)
            bgMusic?.delegate = self as? AVAudioPlayerDelegate
            bgMusic?.prepareToPlay()
            bgMusic?.play()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        }
    }
    
    // Starts time when play button is pressed.
    func startGameTime() {
        
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    // Updates game time on displays
    @objc func updateCounter() -> String {
        
        // Calculate total time since timer started in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime
        
        // Calculate minutes
        let minutes = UInt8(time / 60.0)
        time -= (TimeInterval(minutes) * 60)
        
        // Calculate seconds
        let seconds = UInt8(time)
        time -= TimeInterval(seconds)
        
        // Calculate milliseconds
        let milliseconds = UInt8(time * 100)
        
        // Format time vars with leading zero
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        // Add time vars to relevant labels
        display = "\(strMinutes):\(strSeconds):\(strMilliseconds)"
        timerDisplay.text = display
        print(display)
        
        return display
    }
    
    // Sets up for new game
    func setupNewGame() {
        let cardsData:[UIImage] = PokeMemoryGame.defaultCardImages
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
        pointsDisplay.text = String(format: "%@: 0", NSLocalizedString("POINTS", comment: "points"))
        timerDisplay.text = String(format: "%@: ---", NSLocalizedString("TIME", comment: "time"))
        startButton.setTitle(NSLocalizedString("START", comment: "start"), for: UIControlState())
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameController.numberOfCards > 0 ? gameController.numberOfCards : 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCVC
        cell.showCard(false, animted: false)
        
        guard let card = gameController.cardAtIndex(indexPath.item) else { return cell }
        cell.card = card
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCVC
        
        if cell.shown { return }
        gameController.didSelectCard(cell.card)
        
        collectionView.deselectItem(at: indexPath, animated:true)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let numberOfColumns:Int = self.collectionView(collectionView, numberOfItemsInSection: indexPath.section)
        
        let itemWidth: CGFloat = collectionView.frame.width / 3.0 - 15.0 //numberOfColumns as CGFloat - 10 //- (minimumInteritemSpacing * numberOfColumns))
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // MARK: - MemoryGameDelegate
    
    func memoryGameDidStart(_ game: MemoryGame) {
        collectionView.reloadData()
        collectionView.isUserInteractionEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameViewController.gameTimerAction), userInfo: nil, repeats: true)
        
    }
    
    func memoryGame(_ game: MemoryGame, showCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section:0)) as! CardCVC
            cell.showCard(true, animted: true)
        }
    }
    
    func memoryGame(_ game: MemoryGame, hideCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card) else { continue }
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section:0)) as! CardCVC
            cell.showCard(false, animted: true)
        }
    }
    
    
    func memoryGameDidEnd(_ game: PokeMemoryGame, elapsedTime: TimeInterval) {
        timer?.invalidate()
        
        let elapsedTime = gameController.elapsedTime
        
        let alertController = UIAlertController(
            title: NSLocalizedString("Hurrah!", comment: "title"),
            message: String(format: "%@ %.0f seconds", NSLocalizedString("You finished the game in", comment: "message"), elapsedTime),
            preferredStyle: .alert)
        
        let saveScoreAction = UIAlertAction(title: NSLocalizedString("Save Score", comment: "save score"), style: .default) { [weak self] (_) in
            let nameTextField = alertController.textFields![0] as UITextField
            guard let name = nameTextField.text else { return }
            self?.savePlayerScore(name, score: elapsedTime)
            self?.resetGame()
        }
        saveScoreAction.isEnabled = false
        alertController.addAction(saveScoreAction)
        
        alertController.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Your name", comment: "your name")
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange,
                                                   object: textField,
                                                   queue: OperationQueue.main) { (notification) in
                                                    saveScoreAction.isEnabled = textField.text != ""
            }
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Dismiss", comment: "dismiss"), style: .cancel) { [weak self] (action) in
            self?.resetGame()
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) { }
    }
    
    // MARK - IBAction functions
    
    @IBAction func startButton(_ sender: UIButton) {
        
        // Button sound
        prepareAudios()
        patSound?.play()
        
        // Calls functions
        startGameTime()
        
        // Shows button at beginning of game
        startButton.isHidden = true
        
        // Unhides views after start button is pressed
        pointsView.isHidden = false
        bottomView.isHidden = false
        
        if gameController.isPlaying {
            resetGame()
            startButton.setTitle(NSLocalizedString("Start", comment: "start"), for: UIControlState())
        } else {
            setupNewGame()
            startButton.setTitle(NSLocalizedString("Stop", comment: "stop"), for: UIControlState())
        }
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

//// iPad array for 30 buttons
//pokeImages = [
//    "military chainsaw.png", "tools rope.png", "tools saw.png",
//    "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
//    "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
//    "weapons katana.png", "magic wizard hat.png", "weapons medieval helmet.png",
//    "weapons medieval sword.png", "weapons sledgehammer.png", "weapons wood shield.png",
//    "military chainsaw.png", "tools rope.png", "tools saw.png",
//    "tools screwdriver.png", "tools shovel.png", "tools swiss knife.png",
//    "tools torch.png", "tools wrench.png", "weapons gaunlets.png",
//    "weapons katana.png", "magic wizard hat.png", "weapons medieval helmet.png",
//    "weapons medieval sword.png", "weapons sledgehammer.png", "weapons wood shield.png"
//]

//            [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!, UIImage(named: "14")!, UIImage(named: "15")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "10")!, UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!, UIImage(named: "14")!, UIImage(named: "15")!
//            ]

//    // Function assigns views with tap gestures
//    func tapGesture(_ sender: UITapGestureRecognizer) {
//
//        // Checks if the user has selected more than 0 cards.
//        if selectedImages.count > 0 {
//
//            // if/else statement to deselect a card if the user retaps the same one.
//            if sender.view?.description != selectedImages[0].description {
////                selectedImages.append(UIView)
//                (sender.view?.subviews[0] as! UIImageView).isHidden = false
//            } else {
//                // If 2 cards are selected and have different descriptions, the images are hidden.
//                keepTiles()
//            }
//            print("Tapped - No Match")
//
//            // If there isn't more than one box in the the array, we have to remove the description check or else that array index will be nil and will cause a crash. We still add the selected box to the array.
//        } else {
////            selectedImages.append(UIImage)
//            (sender.view?.subviews[0] as! UIImageView).isHidden = false
//            print("Tapped - Image Added to Array")
//        }
//
//        // If statement to check if 2 cards have been selected.
//        if selectedImages.count == 2 {
//
//            // If statement checks subviews to see if they match.
//            if (selectedImages[0].subviews[0] as! UIImageView).image == (selectedImages[1].subviews[0] as! UIImageView).image {
//                (sender.view?.subviews[0] as! UIImageView).isHidden = false
//                // Disable user interaction so that they cannot tap any other cards.
//                view.isUserInteractionEnabled = false
//
//                // Start a timer for .5 second so user can see the match. Calls removeCards function
//                timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(removeTiles), userInfo: nil, repeats: false)
//                print("Tapped if 2 cards")
//            } else {
//                (sender.view?.subviews[0] as! UIImageView).isHidden = false
//                view.isUserInteractionEnabled = false
//                // Start timer for .5 second so user can see images were NOT a match. Calls hideCards function
//                timer3 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(keepTiles), userInfo: nil, repeats: false)
//                print("Tapped if 2 cards -else")
//            }
//        }
//    }
//
//    // Function used to re-hide images when the user does not get a match.
//    func keepTiles() {
//
//        // Remove points for missing match
//        gamePoints -= 20
//
//        // Not a match sound
//        prepareAudios()
//        patSound?.play()
//
//        for tile in selectedImages {
//            tile.layer.borderWidth = 2.0
//            tile.layer.borderColor = UIColor.yellow.cgColor
//            tile.backgroundColor = UIColor.black
//            (tile.subviews[0] as! UIImageView).isHidden = true
//        }
//
//        // Removes the selected boxes from the selected boxes array, allowing the user to start selecting more boxes.
//        selectedImages.removeAll(keepingCapacity: false)
//
//        // Renables user interaction.
//        view.isUserInteractionEnabled = true
//    }
//
//    // Function used to hide boxes when the user gets a match.
//    func removeTiles() {
//
//        // 1. Replace the image with a blank one
//        // 2. Use the alpha on an image to hide it
//
//
//        // Add points for a match
//        gamePoints += 100
//
//        // Correct match sound
//        prepareAudios()
//        chime?.play()
//
////        for image in pokeImageArray {
////            image.isHidden = true
////        }
//
//        for tile in selectedImages {
//            tile.layer.backgroundColor = UIColor.clear.cgColor
//            tile.layer.borderWidth = 0
//        }
//
//        // Removes the count of 1 card per selection so we know how many cards are left.
//        tileCounter -= 1
//        tileCounter -= 1
//
//        selectedImages.removeAll(keepingCapacity: false)
//
//        // Checks if the number of cards has reached 0.
//        if tileCounter == 0 {
//
//            // Winning cheers
//            prepareAudios()
//            tadaSound?.play()
//            cheering?.play()
//
//            // Stops the game counter once game is completed.
//            timer?.invalidate()
//
//            // Reveals the winner's screen
//            gameOver = true
//
////            gameView.isHidden = true
////            winnersView.isHidden = false
////
////            // Adds the winning text phrase to the winner's screen label.
////            winningTimeText.text! = "You finished in \(display) seconds!"
//        }
//
//        // Enables the user's interaction once two boxes are matched.
//        view.isUserInteractionEnabled = true
//    }
//
//    @IBAction func pokeButtonPressed(_ sender: RoundedButtons) {
//
//
//    }

