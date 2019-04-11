//
//  ViewController.swift
//  firebase_demo
//
//  Created by Admin on 4/9/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    var databaseRef : DatabaseReference?
    
    @IBOutlet weak var textArea: UITextView!
    @IBAction func retrieveBT(_ sender: UIButton) {
        retrieveData()
    }
    @IBOutlet weak var text: UITextField!
    
    @IBAction func okBT(_ sender: UIButton) {
        if text.text != "" {
            databaseRef?.child("name").childByAutoId().setValue(text.text)
            text.text = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        databaseRef = Database.database().reference()
        
    }
    
    
    func retrieveData() {
        var res = ""
        //let userID = Auth.auth().currentUser?.uid
        databaseRef?.child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            //let username = value?["username"] as? String ?? ""
            for s in value!.allValues {
                res += s as! String
                res += "\n"
            }
            self.textArea.text = res
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

