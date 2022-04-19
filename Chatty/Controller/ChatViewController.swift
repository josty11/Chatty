//
//  ChatViewController.swift
//  Chatty
//
//  Created by Татьяна on 19.04.2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hello there"),
        Message(sender: "dani@blabla.com", body: "General Kenobi"),
        Message(sender: "1@2.com", body: "Whoosh")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        messageTextField.layer.cornerRadius = 25
        
        chatTableView.dataSource = self
    }
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - Datasource methods

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
}
