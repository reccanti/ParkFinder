//
//  ViewController.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/2/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class ViewController: UIViewController {

    // MARK: - ivars
    @IBOutlet weak var mapView: MKMapView!
    let metersPerMile: Double = 1609.344
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let park1 = StatePark(name:"Letchworth State Park", latitude: 42.685, longitude: -77.95944)
//        print(park1)
//        
//        if let path = Bundle.main.url(forResource: "parks", withExtension: "js") {
//            // because Data(contentsOf) throws exceptions, we need try!
//            let data = try! Data(contentsOf:path, options:[])
//            // the JSON() constructor is from SwiftyJSON
//            let json = JSON(data:data)
//            print("json=\(json)")
//        } else {
//            print("could not find parks.js!")
//        }
        
        guard let path = Bundle.main.url(forResource: "parks", withExtension: "js") else {
            print("Error: could not find parks.js!")
            return
        }
        
        do {
            let data = try Data(contentsOf:path, options:[])
            let json = JSON(data:data)
            if json != JSON.null {
                parse(json: json)
            } else {
                print("json is null!")
            }
        } catch {
            print("Error: could not initialize the Data() object!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    
    /**
     * Parses a JSON object and prints the results
     */
    func parse(json:JSON) {
        // PARSE the JSON
        // pull the array of dictionaries out of the JSON
        let array = json["parks"].arrayValue
        
        // create and initialize an array to hold our StatePark instances
        var parks = [StatePark]()
        
        // loop through the array
        for d in array {
            var name = d["name"].stringValue
            if name.isEmpty {
                name = "No title found"
            }
            
            // no optional binding necessary!
            let latitude = d["latitude"].floatValue
            let longitude = d["longitude"].floatValue
            
            let park = StatePark(name: name, latitude: latitude, longitude: longitude)
            parks.append(park)
            
            // SwiftyJSON returns "" or 0 if the property doesn't exist
//            let fakeProperty:Int = d["xyzpdq"].intValue as Int
//            print("fakeProperty=\(fakeProperty)") // 0
        }
        print(parks)
        
        // add annotations to the map
        mapView.addAnnotations(parks)
        
        // start zoomed in
        let myRegion = MKCoordinateRegionMakeWithDistance(parks[0].coordinate, metersPerMile * 100, metersPerMile * 100)
        
        mapView.setRegion(myRegion, animated: true)
        mapView.selectAnnotation(parks[0], animated: true)
        
        
    }


}

