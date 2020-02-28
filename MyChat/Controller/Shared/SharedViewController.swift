//
//  SharedViewController.swift
//  MyChat
//
//  Created by Frantisek Varadzin on 27/02/2020.
//  Copyright © 2020 Frantisek Varadzin. All rights reserved.
//

import UIKit

class SharedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    func displayError(message: String) {
           let error = UIAlertController(title: "Chyba", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
           
           error.addAction(okAction)
           present(error, animated: true, completion: nil)
       }
       
 

}
