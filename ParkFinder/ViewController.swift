//
//  ViewController.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/2/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let park1 = StatePark(name:"Letchworth State Park", latitude: 42.685, longitude: -77.95944)
        print(park1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

