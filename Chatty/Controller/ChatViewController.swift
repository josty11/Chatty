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
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        messageTextField.layer.cornerRadius = messageTextField.frame.size.height / 4
        messageTextField.clipsToBounds = true
        
        chatTableView.dataSource = self
        chatTableView.backgroundColor = UIColor(named: K.Colors.darkerGreenBlue)
        chatTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            //let newMessage = Message(sender: messageSender, body: messageBody)
            // Add a new document with a generated ID
            
            //add the text to the db
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("Error adding document: \(e)")
                } else {
                    print("Successfully added data")
                }
            }
            
            loadMessages()
            messageTextField.text = ""
        }
        
        
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
    
    func loadMessages() {
        
        //reload the table view
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            if let e = error {
                print("Error getting documents: \(e)")
            } else {
                if let snapshot = querySnapshot {
                    
                    for document in snapshot.documents {
                        let data = document.data()
                        if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                            
                            let message = Message(sender: sender, body: body)
                            self.messages.append(message)
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                            
                        }
                    }
                }
                
                
            }
        }
    }
}

//MARK: - Datasource methods

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.Colors.yellow)
        } else {
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.Colors.lighterGreen)
        }
        
        return cell
    }
}
