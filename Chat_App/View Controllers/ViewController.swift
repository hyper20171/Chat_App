//
//  ViewController.swift
//  Chat_App
//
//  Created by Philip Tran on 1/23/21.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var nameOfApp: CLTypingLabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfApp.text = "Chat App"
        // Do any additional setup after loading the view.
        signUpButton.layer.cornerRadius = signUpButton.frame.size.height/5
        logInButton.layer.cornerRadius = logInButton.frame.size.height/5
    }

    
}

