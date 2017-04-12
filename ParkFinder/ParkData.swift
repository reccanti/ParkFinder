//
//  ParkData.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/4/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import Foundation

public class ParkData {
    static let sharedData = ParkData()
    var parks = [StatePark]()
    var sortedParks: [StatePark] {
        return parks.sorted {
            $0 < $1
        }
    }
    
    private init() {}
}
