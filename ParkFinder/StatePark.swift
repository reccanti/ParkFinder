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

public class StatePark:NSObject, MKAnnotation, Comparable, NSCoding {
    
    private var name:String
    private var latitude:Float
    private var longitude:Float
    private var parkDescription:String
    
    public var url: URL
    public var image: String?
    
    enum ParkKey: String {
        case nameKey = "name"
        case latitudeKey = "latitude"
        case longitudeKey = "longitude"
        case urlKey = "url"
        case descriptionKey = "description"
        case imageKey = "image"
    }
    
    // MARK: - various initializers
    
    /**
     * Initializes the StatePark with its name,
     * location, and url
     */
    init(name:String, latitude:Float, longitude:Float, url:String, description:String, image:String?) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.url = URL(string: url)!
        self.parkDescription = description
        self.image = image
    }
    
    /**
     * Initializes a StatePark by decoding an
     * object. Part of the NSCoding protocol
     */
    public required init(coder aDecoder:NSCoder) {
        self.name = aDecoder.decodeObject(forKey: ParkKey.nameKey.rawValue) as! String
        self.latitude = aDecoder.decodeFloat(forKey: ParkKey.latitudeKey.rawValue)
        self.longitude = aDecoder.decodeFloat(forKey: ParkKey.longitudeKey.rawValue)
        self.url = aDecoder.decodeObject(forKey: ParkKey.urlKey.rawValue) as! URL
        self.parkDescription = aDecoder.decodeObject(forKey: ParkKey.descriptionKey.rawValue) as! String
        self.image = aDecoder.decodeObject(forKey: ParkKey.imageKey.rawValue) as? String
    }
    
    // MARK: - NSObject properties
    public override var description:String {
        return parkDescription
    }
    
    // MARK: - MKAnnotation properties
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
        return description
    }
    
    // MARK: - Comparable Protocol methods
    public static func == (lhs: StatePark, rhs: StatePark) -> Bool {
        return lhs.name == rhs.name
    }
    
    public static func < (lhs: StatePark, rhs: StatePark) -> Bool {
        return lhs.name < rhs.name
    }
    
    // MARK: - NSCoding Protocol methods
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: ParkKey.nameKey.rawValue)
        aCoder.encode(url, forKey: ParkKey.urlKey.rawValue)
        aCoder.encode(latitude, forKey: ParkKey.latitudeKey.rawValue)
        aCoder.encode(longitude, forKey: ParkKey.longitudeKey.rawValue)
        aCoder.encode(parkDescription, forKey: ParkKey.descriptionKey.rawValue)
        if image != nil {
            aCoder.encode(image, forKey: ParkKey.imageKey.rawValue)
        }
    }
}
