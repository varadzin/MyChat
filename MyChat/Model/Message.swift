//
//  Message.swift
//  MyChat
//
//  Created by Frantisek Varadzin on 27/02/2020.
//  Copyright © 2020 Frantisek Varadzin. All rights reserved.
//

import Foundation



class Message {
    //MARK: Properties
    
    
    
    
    let text: String
    let timestamp: String
    let sender: User
    
    var dictValue: [String: Any] { //tu odosiela data do databazy JSON
        get {
            return ["text":text,
                    "timestamp":timestamp,
                    "sender":[
                        "name":sender.name
                        ]
            ]
        }
        
    }
    
    
    
    //MARK: Object lifecycle
    
    init(text: String, timestamp: String, sender: User) {
        self.text = text
        self.timestamp = timestamp
        self.sender = sender
        
    }
    
    
    init?(json: [String: Any]) {
    
        if let text = json["text"] as? String,
        let timestamp = json["timestamp"] as? String,
            let sender = json["sender"] as? [String: Any],
            let senderName = sender["name"] as? String {
            
            self.text = text
            self.timestamp = timestamp
            self.sender = User(name: senderName)
            
        } else {
            return nil
        }
        
    }
    
}
