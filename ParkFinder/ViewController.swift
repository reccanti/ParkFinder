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

class ViewController: UIViewController, MKMapViewDelegate {

    // MARK: - ivars
    @IBOutlet weak var mapView: MKMapView!
    let metersPerMile: Double = 1609.344
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    
    /**
     * Attempt to load parks data from an external source
     */
    func loadData() {
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
    
    // MARK: - MapViewDelegate Protocol Methods -
    
    /**
     * Detect when an annotation is tapped
     */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let title = view.annotation?.title ?? "No title found"
        print("Tapped \(title!)")
    }
    
    /**
     * Display view with a button
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? StatePark else {
            print("This annotation isn't a StatePark")
            return nil
        }
        
        let identifier = "pinIdentifier"
        let view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            // reuse an existing view
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // make a new view and a put a button in it
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        }
        return view
    }

    /**
     * Handle what happens when the user clicks the info 
     * button on the annotation is clicked
     */
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? StatePark else {
            print("This annotation isn't a StatePark")
            return
        }
        print("Tapped info button for \(annotation.description)")
        print("Maybe we could do something interesting here, like go to a related URL, open the maps app and show the location, or show some park info in a new VC or tab.")
    }
}

