////
////  HighScores.swift
////  PokéMatch
////
////  Created by Allen Boynton on 5/29/17.
////  Copyright © 2017 Allen Boynton. All rights reserved.
////
//
//import Foundation
//
//fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
//    switch (lhs, rhs) {
//    case let (l?, r?):
//        return l < r
//    case (nil, _?):
//        return true
//    default:
//        return false
//    }
//}
//
//
//let kHighscoresUserDefaultsKey = "Highscores"
//
//class Highscores {
//    static let sharedInstance = Highscores()
//    
//    func getHighscores() -> [Dictionary<String,String>] {
//        return userDefaults().array(forKey: kHighscoresUserDefaultsKey) as? [Dictionary<String,String>] ?? []
//    }
//    
//    func saveHighscore(_ name: String, score: TimeInterval) {
//        let entry = ["name": name, "score": String(score)]
//        
//        var scores = getHighscores()
//        scores.append(entry)
//        
//        let sortedScores = scores.sorted { (entry1, entry2) -> Bool in
//            let n1: String = entry1["score"]!
//            let n2: String = entry2["score"]!
//            
//            return Double(n1) < Double(n2)
//        }
//        
//        if scores.count > 10 {
//            scores.removeLast()
//        }
//        
//        userDefaults().set(sortedScores, forKey: kHighscoresUserDefaultsKey)
//    }
//    
//    fileprivate func userDefaults() -> UserDefaults {
//        return UserDefaults.standard
//    }
//}
