//
//  RegisterViewController.swift
//  Chatty
//
//  Created by Татьяна on 19.04.2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 25
        passwordTextField.layer.cornerRadius = 25
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
    }
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("Error creating a new user, \(e)")
                } else {
                    //navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.registerToChatSegue, sender: self)
                }
            }
        } else {
            print("Please type your email and password")
        }
    }
    
}
