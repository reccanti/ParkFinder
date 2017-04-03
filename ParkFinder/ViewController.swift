//
//  ViewController.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/2/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

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
            print("json=\(json)")
        } catch {
            print("Error: could not initialize the Data() object!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

