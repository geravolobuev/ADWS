//
//  Game.swift
//  Apple Pie
//
//  Created by MAC on 02/03/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) -> Bool {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
            return false
        } else {
            return true
        }
    }
    
    var formatedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
