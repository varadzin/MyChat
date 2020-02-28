//
//  NameViewController.swift
//  MyChat
//
//  Created by Frantisek Varadzin on 26/02/2020.
//  Copyright © 2020 Frantisek Varadzin. All rights reserved.
//

import UIKit

class NameViewController: SharedViewController, UITextFieldDelegate  {

    // MARK: Properties
    
  @IBOutlet weak var txtInput: UITextField!
    
    // MARK: - Object lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = UserDefaults.standard.object(forKey: "UserDefaultKeyName") as? String {
            txtInput.text = name
            
        }
        
        
        
    }
    
// MARK: - Action
    
    @IBAction func changeBackground() {
        
        view.backgroundColor = .blue
        
        
        
        
    }
    // skryvanie klavesnice
    
    @IBAction func hideKeyboard() {
        
        txtInput.resignFirstResponder()
        
    }
    
    
    @IBAction func goAction() {
        
        if let name = txtInput.text, name.count >= 2 {
            let me = User(name: name)
       
            startChat(me: me)
            
            saveMyName(name)
            
        } else {
            displayError(message: "Nespravne meno")
            
        }
    }
 
    func startChat(me: User) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil) // tu definujeme ze existuje hlavna obrazovka a to sme dali do premenej storyboard
        
        if let chatViewController = storyboard.instantiateViewController(identifier: "ChatViewController") as? ChatViewController { // musi tam byt if a potom as?
        
            chatViewController.me = me //prenos mena medzi obrazovkami
            
            navigationController?.pushViewController(chatViewController, animated: true)
            
            
//            present(chatViewController, animated: true, completion: {
//
//                self.txtInput.text = String() //tu vycistim zadane meno
//
//            })
            
            // tu sme vytvorili prepojenie na nasledujujucu obrazovku, piseme tam scenu ktorej ID sme zadali na druhej obrazovke
        }
        
        
        
        
    }
   // aby pri logovani po stlaceni Enter sa spustil chat
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goAction()
        return true
    }
    
    func saveMyName(_ name: String) {
        
       
            UserDefaults.standard.set(name, forKey: "UserDefaultKeyName")
            UserDefaults.standard.synchronize()
            
        
    }
    
    
    
    
}
