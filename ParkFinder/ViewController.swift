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

let showParkNotification = NSNotification.Name("showParkNotification")

class ViewController: UIViewController, MKMapViewDelegate {

    // MARK: - ivars
    @IBOutlet weak var mapView: MKMapView!
    let metersPerMile: Double = 1609.344
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the mapView delegate to self
        mapView.delegate = self
        
        // listen for showMap notifications
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(showMap), name: showParkNotification, object: nil)
        
        // load location data for pins
        loadData()
    }
    
    /**
     * Hide the Navigation bar on the map before
     * the view appears
     */
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    /**
     * Display the Navigation bar before the view
     * disappears
     */
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    /**
     * Deinitialize the ViewController
     */
    deinit {
        // remove notification reference
        NotificationCenter.default.removeObserver(self)
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
            var description = d["description"].stringValue
            if description.isEmpty {
                description = "No description found"
            }
            let imageString:String = d["image"].stringValue
            var image:String? = nil
            if !imageString.isEmpty {
                image = imageString
            }
            
            // no optional binding necessary!
            let latitude = d["latitude"].floatValue
            let longitude = d["longitude"].floatValue
            
            let url = d["url"].stringValue
            
            let park = StatePark(
                name: name,
                latitude: latitude,
                longitude: longitude,
                url: url,
                description:description,
                image:image
            )
            
            parks.append(park)
        }
        
        // add annotations to the map
        mapView.addAnnotations(parks)
        
        // start zoomed in
        let myRegion = MKCoordinateRegionMakeWithDistance(parks[0].coordinate, metersPerMile * 100, metersPerMile * 100)
        
        mapView.setRegion(myRegion, animated: true)
        mapView.selectAnnotation(parks[0], animated: true)
        
        ParkData.sharedData.parks = parks
    }
    
    /**
     * Opens the URL of the given StatePark
     */
    func openURL(forStatePark park: StatePark) {
        UIApplication.shared.open(
            park.url,
            options: [:],
            completionHandler: {
                (success) in
            })
    }
    
    // MARK: - MapViewDelegate Protocol Methods -
    
    /**
     * Detect when an annotation is tapped
     */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let title = view.annotation?.title ?? "No title found"
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

        // make a new view and a put a button in it
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        if annotation.image != nil {
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
        if annotation.image != nil {
            performSegue(withIdentifier: "toPanorama", sender:nil)
        }
    }
    
    // MARK: - Notifications -
    func showMap(notification: NSNotification) {
        // change to map tab - this works as long as the map is on the first tab
        tabBarController?.selectedIndex = 0
        
        // select the park annotation that was passed over
        if let park = notification.userInfo!["park"] as? MKAnnotation {
            mapView.selectAnnotation(park, animated: true)
        }
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toPanorama" {
            print("testing panorama")
            guard let annotation = mapView.selectedAnnotations[0] as? StatePark else {
                return false
            }
            if annotation.image != nil {
                print("image not nil")
                return true
            } else {
                return false
            }
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPanorama" {
            guard let annotation = mapView.selectedAnnotations[0] as? StatePark else {
                return
            }
            let panoramaView = segue.destination as! ParkPanoramaViewController
            panoramaView.park = annotation
        }
    }
}

