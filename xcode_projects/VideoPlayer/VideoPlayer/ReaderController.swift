//
//  ReaderController.swift
//  VideoPlayer
//
//  Created by Admin on 4/7/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit

class ReaderController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    @IBAction func goBackBT(_ sender: UIButton) {
        safeAlert()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func safeAlert(){
        let alert = UIAlertController(title: "All About Study", message:"Learn more?", preferredStyle: UIAlertController.Style.alert )
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Take a break", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Keep going", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            let text = alert.textFields![0].text
            if text == "123" {
                self.performSegue(withIdentifier: "goWatch", sender: nil)
            } else {
                self.textArea.text = "You already finished reading the whole calculus book! Your parents should feel so pround of you!"
            }
        }))
        self.present(alert, animated:  true, completion:  nil)
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
