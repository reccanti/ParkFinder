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
    
    // a reference to NotificationCenter
    let nc = NotificationCenter.default
    
    // a computed property that returns the sorted parks array
    var sortedParks: [StatePark] {
        return parks.sorted {
            $0 < $1
        }
    }
    
    /**
     * initialize the ParkData
     */
    private init() {
        loadFavorites()
    }
    
    // MARK: - favorites methods
    
    // an array that holds parks that have been favorited
    private var _favorites = [StatePark]()
    
    /**
     * initialize the favorites array by pulling it from
     * the filesystem
     */
    func loadFavorites() {
        //
    }
    
    /**
     * save the current favorites array to the filesystem
     */
    func saveFavorites() {
        //
    }
    
    /**
     * Adds a StatePark to the favorites array and
     * updates the necessary items
     */
    func addToFavorites(_ park:StatePark) {
        _favorites.append(park)
        nc.post(name: updateFavoritesNotification, object: _favorites, userInfo: nil)
    }
    
    /**
     * Inserts a StatePark into the favorites array
     * and updates the necessary items
     */
    func insertIntoFavorites(_ park:StatePark, at:Int) {
        _favorites.insert(park, at: at)
    }
    
    /**
     * Removes a StatePark into the favorites array
     * and updates the necessary items
     */
    func removeFromFavorites(at: Int) -> StatePark {
        return _favorites.remove(at: at)
    }
    
    /**
     * return a reference to the favorites array
     */
    func getFavorites() -> [StatePark] {
        return _favorites
    }
}
