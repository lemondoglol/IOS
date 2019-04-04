//
//  ViewController.swift
//  GPS
//
//  Created by Admin on 4/2/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    // current position
    let place = CLLocationCoordinate2D(latitude: 25, longitude: -25)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            guard let mapController = segue.destination as? MapController else {return}
            mapController.place = place
        }
    }


}

