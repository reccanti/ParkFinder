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
    
    // an array that holds park data
    var parks = [StatePark]()
    
    // a computed property that returns the sorted parks array
    var sortedParks: [StatePark] {
        return parks.sorted {
            $0 < $1
        }
    }
    
    private init() {
    }
    
    // MARK: - favorites methods
    
    // an array that holds parks that have been favorited
    private var _favorites = [StatePark]()
//    var favorites: [StatePark] {
//        set(newValue) {
//            let nc = NotificationCenter.default
//            nc.post(name: updateFavoritesNotification, object: favorites, userInfo: nil)
//        }
//        get {
//            
//        }
//    }
    
    func addToFavorites(_ park:StatePark) {
        _favorites.append(park)
        let nc = NotificationCenter.default
        let data = ["park":park]
        nc.post(name: updateFavoritesNotification, object: _favorites, userInfo: data)
    }
    
    func getFavorites() -> [StatePark] {
        return _favorites
    }
}
