//
//  loginViewController.swift
//  Chat_App
//
//  Created by Philip Tran on 1/23/21.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //messageBubble.layer.cornerRadius = messageBubble.frame.size.height/5
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        if let emailText = email.text, let passwordText = password.text{
            //[weak self]
            Auth.auth().signIn(withEmail: emailText, password: passwordText) {authResult, error in
             // guard let strongSelf = self else { return }
                if let e = error{
                    print(e)
                }else{
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
