//
//  ViewController.swift
//  Chatty
//
//  Created by Татьяна on 19.04.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = ""
        var charIndex = 0.0
        
        for letter in K.welcomeLabel {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.welcomeLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.welcomeLoginSegue, sender: self)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.welcomeRegisterSegue, sender: self)
    }
}

