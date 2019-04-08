//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Admin on 4/6/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var playZone: UIView!
    
    let player = AVPlayerViewController()
    var video:AVPlayer?
    
    @IBAction func playBT(_ sender: UIButton) {
        if let path = Bundle.main.path(forResource: "videoplayback", ofType: "mp4"){
            video = AVPlayer(url: URL(fileURLWithPath: path))
            player.view.frame = playZone.frame
            self.addChild(player)
            self.view.addSubview(player.view)
            player.player = video
            
            video!.isMuted = false
            video!.play()
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapListener))
            tap.numberOfTapsRequired = 1
            
            player.view.isUserInteractionEnabled = false
            player.view.addGestureRecognizer(tap)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapListener))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        //self.view.addGestureRecognizer(tap)
        player.view.addGestureRecognizer(tap)
        playZone.addGestureRecognizer(tap)
    }

    @objc func tapListener(sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: "goReader", sender: nil)
        if video != nil {
            video!.isMuted = true
        }
    }

}

