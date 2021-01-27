//
//  messageViewController.swift
//  Chat_App
//
//  Created by Philip Tran on 1/25/21.
//

import UIKit
import Firebase

class messageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var content: UITextField!
    
    //Why do I need :[Message] if it works perfectly without it? Maybe just to help developer understand code better.
    
    var messages:[Message] = []
    
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName:"MessageCell", bundle:nil), forCellReuseIdentifier:"ReusableCell")
        updateMessageScreen()
        navigationItem.hidesBackButton = true
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error")
        }
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = content.text, let user = Auth.auth().currentUser?.email{
            if content.text == ""{
                return
            }
            let c:[String:Any] = [
                "sender":user,
                "body":message,
                "date":Date().timeIntervalSince1970
            ]
            db.collection("message").addDocument(data: c) { (error) in
                if let e = error{
                    print(e)
                }else{
                    print("Success!")
                }
            }
        }
        content.text = ""
    }
    
    func updateMessageScreen(){
        
        db.collection("message")
            .order(by:"date")
            .addSnapshotListener { (querySnapShot, error) in
            self.messages = []
            if let e = error{
                print(e)
            }
            else{
                if let snapShots = querySnapShot?.documents{
                    for doc in snapShots{
                        let data = doc.data()
                        if let sender = data["sender"] as? String, let messageBody = data["body"] as? String{
                            self.messages.append(Message(sender: sender, body: messageBody))
                            DispatchQueue.main.async{
                                self.tableView.reloadData() //Happens in background so make it go to main thread
                                let indexPath = IndexPath(row: self.messages.count-1, section:0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                        
                }
            }
        }
    }
}

//MARK:-This is to setup table view content

extension messageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ReusableCell") as! MessageCell
        
        cell.label.text = messages[indexPath.row].body
        
        if messages[indexPath.row].sender == Auth.auth().currentUser?.email{
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            //cell.messageBubble.backgroundColor = UIColor(named:"BrandLightPurple")
            
        }
        else{
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named:"Green")
            
        }
        
        return cell
    }
    
    
}
