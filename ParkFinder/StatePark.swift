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
import UIKit

public class StatePark:NSObject, MKAnnotation, Comparable {
    
    private var name:String
    private var latitude:Float
    private var longitude:Float
    
    public var url: URL
    
    init(name:String, latitude:Float, longitude:Float, url:String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.url = URL(string: url)!
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
