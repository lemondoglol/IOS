//
//  ViewController.swift
//  bikes
//
//  Created by Admin on 4/2/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var places: [Place]?
    var locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func locationServiceBT(_ sender: UIButton) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            startTracking()
        } else {
            // ask for Access
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        loadPlist()
    }
    
    func startTracking() {
        locationManager.startUpdatingLocation()
    }
    
    func loadPlist() {
        if let pURL = Bundle.main.url(forResource: "Places", withExtension: "plist") {
            // decode
            if let data = try? Data(contentsOf: pURL) {
                places = try? PropertyListDecoder().decode([Place].self, from: data)
                
                if let ps = places {
                    for place in ps {
                        print(place)
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get current location
        let latest = locations.last
        if let loc = previousLocation {
            let dist = loc.distance(from: latest!)
            label.text = String(format: "%.1f meters", dist)
        } else {
            previousLocation = latest
            label.text = "0 meters"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            startTracking()
        }
    }
    


}

