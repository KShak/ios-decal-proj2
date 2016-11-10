//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
//    @IBOutlet weak var guessButton: UIButton!
    
    
    var guessCount = Int(0)
    
    var guessing : [String] = [String]()
    var guessingDisplay : [String] = [String]()
    var guessed : [String] = [String]()
    var maxGuesses : Int = 6
    
    @IBOutlet weak var testy2: UITextField!
    @IBOutlet weak var testy1: UITextField!
    @IBOutlet weak var testy: UITextField!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var numIncorrectGuesses: UILabel!
    @IBOutlet weak var gameStatus: UITextField!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var wordGuessing: UILabel!
    @IBOutlet weak var actualGuessButton: UIButton!
    
    @IBAction func startOver() {
        self.viewDidLoad()
    }
    
    @IBAction func guessButton() {
        var tempString: String = guessTextField.text!
        tempString = tempString.lowercased()
        let alreadyGuessed = guessingDisplay.contains(tempString) || guessed.contains(tempString)
        if (tempString == " " || tempString == "" || tempString.characters.count > 1) {
            let alert = UIAlertController(title: "INVALID GUESS", message: "Your guess must be exactly 1 character that is not a space as spaces are already shown for you.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if (alreadyGuessed) {
            let alert = UIAlertController(title: "ALREADY GUESSED", message: "You have already guessed this character", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            var counter = 0
            var indices : [Int] = [Int]()
            for item in guessing {
                if (item == tempString) {
                    indices += [counter]
                }
                counter += 1
            }
            if (indices.count > 0) {
                for index in indices {
                    guessingDisplay[index] = tempString
                }
                wordGuessing.text = guessingDisplay.joined(separator: " ")
                if (guessingDisplay.contains("_") == false) {
                    let alert = UIAlertController(title: "GAME OVER: YOU WIN!", message: "You have guessed the word within " + String(maxGuesses) + " guesses.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    guessTextField.isEnabled = false
                    actualGuessButton.isEnabled = false
                    gameStatus.text = "YOU WON"
                }
            } else {
                guessCount += 1
                numIncorrectGuesses.text = String(guessCount)
                guessed += [tempString]
                incorrectGuesses.text = guessed.joined(separator: " ")
                var imageName = "hangman" + String(guessCount + 1) + ".gif"
                hangmanImage.image = UIImage(named: imageName)
                if (guessCount == maxGuesses) {
                    let alert = UIAlertController(title: "GAME OVER: YOU LOSE!", message: "You have used all " + String(maxGuesses) + " of your guesses. The answer was: \"" + guessing.joined(separator: "") + "\".", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    guessTextField.isEnabled = false
                    actualGuessButton.isEnabled = false
                    gameStatus.text = "YOU LOST"
                }
            }
        }
        guessTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessTextField.delegate = self
        guessCount = Int(0)
        guessing = [String]()
        guessingDisplay = [String]()
        guessed = [String]()
        guessTextField.text = ""
        testy.isEnabled = false
        testy1.isEnabled = false
        testy2.isEnabled = false
        gameStatus.isEnabled = false
        guessTextField.isEnabled = true
        actualGuessButton.isEnabled = true
        gameStatus.text = "GAME ONGOING"
        hangmanImage.image = UIImage(named: "hangman1.gif")
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase().lowercased()
        print(phrase)
        
        
        for i in (phrase.characters) {
            if (i == " ") {
               guessingDisplay += [" "]
            } else {
                guessingDisplay += ["_"]
            }
            guessing += [String(i)]
        }
        wordGuessing.text = guessingDisplay.joined(separator: " ")
        incorrectGuesses.text = "NO GUESSES YET"
        numIncorrectGuesses.text = String(guessCount)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
