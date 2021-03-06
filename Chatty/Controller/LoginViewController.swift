//
//  LoginViewController.swift
//  Chatty
//
//  Created by Татьяна on 19.04.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.layer.cornerRadius = 25
        passwordTextField.layer.cornerRadius = 25
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("Error signing the user, \(e)")
                } else {
                    self.performSegue(withIdentifier: K.loginToChatSegue, sender: self)
                }
            }
        }
    }
    
}
