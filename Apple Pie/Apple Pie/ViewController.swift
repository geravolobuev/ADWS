//
//  ViewController.swift
//  Apple Pie
//
//  Created by MAC on 02/03/2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    
    var currentGame: Game!
    var currentPlayer = 1 {
        didSet {
            currentPlayerLabel.text = "Current Player: \(currentPlayer)"
        }
    }
    var listOfWords = ["pie", "ball", "foot", "eye", "happy"]
    let incorrectMovesAllowed = 7
    var points = 0
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        letters = currentGame.formatedWord.map { String($0) }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        if currentGame.playerGuessed(letter: letter) {
            points += 1
            pointsLabel.text = "Points: \(points)"
        } else {
            changePlayer()
        }
        updateGameState()
    }
    
    func changePlayer() {
        if currentPlayer == 1 {
            currentPlayer = 2
        } else {
            currentPlayer = 1
        }
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formatedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
}

