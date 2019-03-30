//
//  CircleContainer.swift
//  circles
//
//  Created by Admin on 3/29/19.
//  Copyright © 2019 lemondog. All rights reserved.
//


// model for this project
import Foundation
import UIKit

struct Circle : Codable{
    var center: CGPoint
    var radius: CGFloat
    
    init(c: CGPoint, r: CGFloat) {
        center = c
        radius = r
    }
}

class CircleContainer : Codable{
    var circles: [Circle] = []
    
    init(){
        circles = []
    }
    
    init?(json: Data){
        if let decoded = try? JSONDecoder().decode(CircleContainer.self, from: json){
            circles = decoded.circles;
        }
    }
    
    var json: Data?{
        return try? JSONEncoder().encode(self)
    }
    
}
