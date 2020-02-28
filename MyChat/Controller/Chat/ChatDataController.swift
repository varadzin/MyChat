//
//  ChatDataController.swift
//  MyChat
//
//  Created by Frantisek Varadzin on 28/02/2020.
//  Copyright © 2020 Frantisek Varadzin. All rights reserved.
//

import Foundation
import Firebase

protocol ChatDataControllerDelegate: class {
    func dataControllerDidUpdateData()
    func dataControllerDidFail(error: Error)
    func dataControllerDidStartLoading()
    func dataControllerDidStopLoading()
}



// protokol rovnaky nazov ako subor + Delegate, protokol urcenie nejakeho spravania



class ChatDataController {
    
    //MARK: - Properties
    
       private var database: DatabaseReference!
      private(set) var messages = [Message]() //prazdne pole typu Message
    weak var delegate: ChatDataControllerDelegate!
     
    
    init() {
         database = Database.database().reference(withPath: "Messages")
    }
    
    deinit {
        print("koncim")
    }
    
    
    
    // MARK: Firebase
       func sendData(message: Message) {
           
           let trigger = database.childByAutoId()
           
           trigger.setValue(message.dictValue)
           
           
       }
       
    func observeDatabase() {
        delegate.dataControllerDidStartLoading()
        
           database.observe(DataEventType.childAdded, with: { (snapshot) in
               
            
            
               if let json = snapshot.value as? [String: Any],
                   let message = Message(json: json) {
                   
                   self.messages.insert(message, at: 0)
                self.delegate.dataControllerDidUpdateData()
                   
               }
               
               
               // hlasenie chyby ked sa nevie dostat do databazy
               
           }) { (error) in
            
            self.delegate.dataControllerDidStopLoading()
            self.delegate.dataControllerDidFail(error: error)
            
           }
        func stopObservingDatabase() {
            
            database.removeAllObservers()
        }
           
           // ak sa v databazy objavia nove data tak sa funkcia spusti
           
       }
    
    
   
}
