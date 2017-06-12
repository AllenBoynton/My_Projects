//
//  PokeMemoryGame.swift
//  PokéMatch
//
//  Created by Allen Boynton on 5/29/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import Foundation
import UIKit.UIImage

// MARK: - MemoryGameDelegate

protocol MemoryGameDelegate {
    func memoryGameDidStart(_ game: PokeMemoryGame)
    func memoryGame(_ game: PokeMemoryGame, showCards cards: [Card])
    func memoryGame(_ game: PokeMemoryGame, hideCards cards: [Card])
    func memoryGameDidEnd(_ game: PokeMemoryGame, elapsedTime: TimeInterval)
}

// MARK: - MemoryGame

class PokeMemoryGame {
    
    var pokeMatchVC: PokeMatchVC!

    // MARK: - Properties
    
    static var defaultCardImages: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "4")!,
        UIImage(named: "5")!,
        UIImage(named: "6")!,
        UIImage(named: "7")!,
        UIImage(named: "8")!,
        UIImage(named: "9")!,
        UIImage(named: "10")!
    ]
    
    var cards: [Card] = [Card]()
    var delegate: MemoryGameDelegate?
    var isPlaying: Bool = false
    
    fileprivate var cardsShown: [Card] = [Card]()
    fileprivate var startTime: Date?
    
    // Gets number of cards
    var numberOfCards: Int {
        get {
            print("Number of cards: \(cards.count)")
            return cards.count
        }
    }
    
    // Calculates time passed
    var elapsedTime: TimeInterval {
        get {
            guard startTime != nil else {
                return -1
            }
            return Date().timeIntervalSince(startTime!)
        }
    }
    
    // MARK: - Methods
    
    // Operations to start off a new game
    func newGame(_ cardsData: [UIImage]) {
        cards = randomCards(cardsData)
        startTime = Date.init()
        isPlaying = true
        delegate?.memoryGameDidStart(self)
        print("Cards: \(cards)")
    }
    
    // Operations when game has been stopped
    func stopGame() {
        isPlaying = false
        cards.removeAll()
        cardsShown.removeAll()
        startTime = nil
    }
    
    // Function to determine shown unpaired and paired cards
    func didSelectCard(_ card: Card?) {
        guard let card = card else { return }
        
        delegate?.memoryGame(self, showCards: [card])
        
        // If cards are not a match
        if unpairedCardShown() {
            let unpaired = unpairedCard()!
            if card.equals(unpaired) {
                cardsShown.append(card)
                // Add points
                
            } else {
                let unpairedCard = cardsShown.removeLast()
                
                let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    self.delegate?.memoryGame(self, hideCards: [card, unpairedCard])
                }
            }
        } else {
            // If cards are a match
            cardsShown.append(card)
            // Subtract points
            
        }
        
        // Adjusts remaining cards. If none -> finish the game
        if cardsShown.count == cards.count {
            finishGame()
        }
    }
    
    // Helps assign cards and adjusts card index
    func cardAtIndex(_ index: Int) -> Card? {
        if cards.count > index {
            return cards[index]
        } else {
            return nil
        }
    }
    
    func indexForCard(_ card: Card) -> Int? {
        for index in 0...cards.count - 1 {
            if card === cards[index] {
                return index
            }
        }
        return nil
    }
    
    // Determines if game is being played and if not...capture time
    fileprivate func finishGame() {
        // Game Over methods
        isPlaying = false
        delegate?.memoryGameDidEnd(self, elapsedTime: elapsedTime)
    }
    
    // Matches cards with same value using remainder
    fileprivate func unpairedCardShown() -> Bool {
        return cardsShown.count % 2 != 0
    }
    
    // Assigns card to be assigned with a match
    fileprivate func unpairedCard() -> Card? {
        let unpairedCard = cardsShown.last
        return unpairedCard
    }
    
    // Pick random cards for game board
    fileprivate func randomCards(_ cardsData:[UIImage]) -> [Card] {
        var cards = [Card]()
        for i in 0...cardsData.count-1 {
            let card = Card.init(image: cardsData[i])
            cards.append(contentsOf: [card, Card.init(card: card)])
        }
        cards.shuffle()
        return cards
    }
}
