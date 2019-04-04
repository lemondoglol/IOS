//
//  ButtonController.swift
//  image
//
//

import UIKit

class ButtonController: UIViewController {

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let ident = segue.identifier
        let dest = segue.destination as? PhotoViewController
        
        switch ident {
        case "moon":
            // from online url
            dest?.imageURL = URL(string: "https://kelehers.me/tmp/moon.jpg")
        case "orion":
            dest?.imageURL = URL(string: "https://kelehers.me/tmp/orion.jpg")
        case "earthrise":
            dest?.imageURL = URL(string: "https://kelehers.me/tmp/earthrise.jpg")
        default:
            break
        }
        
        dest?.title = ident
    }
}
