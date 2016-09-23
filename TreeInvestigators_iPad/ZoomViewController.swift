//
//  ZoomViewController.swift
//  TreeInvestigators_iPad
//
//  Created by Zach Fuller on 6/11/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController{
    
    @IBOutlet weak var zoomImage: UIImageView!
    var zoomImageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomImage.image = UIImage(named:zoomImageName)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}