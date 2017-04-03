//
//  StatePark.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/3/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import Foundation

public class StatePark:NSObject {
    
    private var name:String
    private var latitude:Float
    private var longitude:Float
    
    init(name:String, latitude:Float, longitude:Float) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public override var description:String {
        return "\(name) : (\(latitude),\(longitude))"
    }
}
