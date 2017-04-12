//
//  StatePark.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/3/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//
import Foundation

import MapKit
import CoreLocation

public class StatePark:NSObject, MKAnnotation, Comparable {
    
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
    
    public var coordinate:CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
    }
    
    // Computed properties
    // These are optional in the MKAnnotationprotocol,
    // which means that the map will call them if they exist
    public var title:String? {
        return name
    }
    
    public var subtitle:String? {
        return "I ❤️ NY"
    }
    
    // MARK: - Comparable Protocol methods
    public static func == (lhs: StatePark, rhs: StatePark) -> Bool {
        return lhs.name == rhs.name
    }
    
    public static func < (lhs: StatePark, rhs: StatePark) -> Bool {
        return lhs.name < rhs.name
    }
}
