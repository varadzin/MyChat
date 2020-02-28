//
//  ChatViewController.swift
//  MyChat
//
//  Created by Frantisek Varadzin on 26/02/2020.
//  Copyright © 2020 Frantisek Varadzin. All rights reserved.
//

import UIKit

class ChatViewController: SharedViewController, UITableViewDataSource, UITableViewDelegate {
   // UITableViewDataSource cez to budem naplnat chat
    
    
    // MARK: - Properties
    
    var me: User!
    private var dataController: ChatDataController!
    
    
   private var dateFormatter: DateFormatter!

    
    //private zabezpeci ze do premmenej moze zapisovat iba ChatViewController
    
    
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
        // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        dataController = ChatDataController()
        dataController.delegate = self
        dataController.observeDatabase()
        
        applyAppearance()
     
        

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
   func applyAppearance() {
   
    
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
    }
    
    
    
        // MARK: - Action
    
    @IBAction func backAction() {
        // v modale sa pouziva na zminutie = dismiss(animated: true, completion: nil)
  
        navigationController?.popViewController(animated: true)
    
    }
    
    
    
    @IBAction func sendAction() {
        
   
        
        let time = dateFormatter.string(from: Date())
        
        if let text = txtMessage.text,
        text.count > 0 {
            let message = Message(text: text, timestamp: time, sender: me)
            
            txtMessage.text = ""
        
            dataController.sendData(message: message)
            
            
            
        } else {
            displayError(message: "Zadaj spravu")
        }
        
        
        
    }
    

    
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.messages.count //zavola nasledujucu fciu tolko krat kolko je poloziek messages v Message
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = dataController.messages[indexPath.row]
        
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        cell.lblText.text = message.text
        cell.lblSender.text = message.sender.name
        cell.lblTime.text = message.timestamp
        
        
        
        return cell
        
    } // tu taham hodnoty bunky
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
}

extension ChatViewController: ChatDataControllerDelegate {
    func dataControllerDidUpdateData() {
        tableView.reloadData()
    }
    
    func dataControllerDidFail(error: Error) {
        displayError(message: error.localizedDescription)
    }
    
    func dataControllerDidStartLoading() {
        
    }
    
    func dataControllerDidStopLoading() {
        
    }
    
    
}
