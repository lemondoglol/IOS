//
//  DocumentViewController.swift
//  circles
//
//  Created by Admin on 3/29/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var documentNameLabel: UILabel!
    
    // so it can easily access document
    var document: Document?
    var single: UITapGestureRecognizer!
    var double: UITapGestureRecognizer!
    
    @objc func singleTap(recog: UITapGestureRecognizer){
        let loc = recog.location(in: view)
        if let container = document?.container {
            container.circles.append(Circle(c: loc, r: 50))
            view.setNeedsDisplay()
            document?.updateChangeCount(.done)
        }
    }
    
    @objc func doubleTap(recog: UITapGestureRecognizer){
        dismiss(animated: true){
            self.document?.close(completionHandler: nil)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (gestureRecognizer == single) && otherGestureRecognizer == double
    }
    
    // mainly focus on this one. refresh stored data here
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                if let circleView = self.view as? CircleView {
                    circleView.document = self.document
                    circleView.setNeedsDisplay()
                }
                self.single = UITapGestureRecognizer(target: self, action: #selector(self.singleTap))
                self.single.numberOfTapsRequired = 1
                self.single.numberOfTouchesRequired = 1
                self.view.addGestureRecognizer(self.single)
                self.single.delegate = self
                
                self.double = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
                self.double.numberOfTapsRequired = 2
                self.double.numberOfTouchesRequired = 1
                self.view.addGestureRecognizer(self.double)
                
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
