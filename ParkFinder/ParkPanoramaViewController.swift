//
//  ParkPanoramaViewController.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/15/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import UIKit

class ParkPanoramaViewController: UIViewController {

    @IBOutlet weak var parkVRView: GVRPanoramaView!
    var park: StatePark!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Cardboard View"
        parkVRView.enableCardboardButton = true
        parkVRView.load(UIImage(named: park.image!), of: GVRPanoramaImageType.mono)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
