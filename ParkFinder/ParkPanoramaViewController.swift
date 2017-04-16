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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        parkVRView.enableCardboardButton = true
        parkVRView.load(UIImage(named: "andes.jpg"), of: GVRPanoramaImageType.stereoOverUnder)
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
