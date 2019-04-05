//
//  TableViewController.swift
//  TableView
//
//  Created by Admin on 4/4/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var when: UILabel!
}


// its a UIViewController
class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var scores: [(String,String,String)] = []
    
    // remember to do this one
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        scores = [("1","400","yesterday"), ("2","50","today")]
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let myCell = cell as? Cell {
            myCell.rank.text = scores[indexPath.row].0
            myCell.points.text = scores[indexPath.row].1
            myCell.when.text = scores[indexPath.row].2
        }
        return cell
    }
    
    
    
    
}
