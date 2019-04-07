//
//  ViewController.swift
//  GPS
//
//  Created by Admin on 4/2/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class ViewController: UIViewController {

    // current position
    let place = CLLocationCoordinate2D(latitude: 25, longitude: -25)
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            let path = Bundle.main.path(forResource: "Epic Sax Guy [Original] [HD]", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: path!) as URL)
            // set session for playing backgroup
            // also go to Capabilities to set up background mode
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            player.play()
        } catch {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            guard let mapController = segue.destination as? MapController else {return}
            mapController.place = place
        }
    }


}

