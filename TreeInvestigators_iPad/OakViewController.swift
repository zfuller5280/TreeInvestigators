//
//  OakViewController.swift
//  TreeInvestigators_iPad
//
//  Created by Zach Fuller on 6/9/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.
//

import UIKit

class OakViewController: UIViewController, Dimmable  {
    
    var imageName = "NoImage.png"
    var buttonState = false
    var buttonImage = "NoImage.png"
    var zoomImageName = "text_box_flower_oak.png"
    
    let dimLevel: CGFloat = 0.45
    let dimSpeed: Double = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Oak Trees"
    }
    
    @IBAction func a_seedlingButton(sender: AnyObject) {
        self.imageName = "seedling_text.png"
        self.buttonImage = "NoImage.png"
    }
    
    @IBAction func a_seedButton(sender: AnyObject) {
        self.imageName = "text_box_acorn.png"
        self.buttonImage = "NoImage.png"
    }

    @IBAction func a_saplingButton(sender: AnyObject) {
        self.imageName = "text_box_oaksap.png"
        self.buttonImage = "NoImage.png"
    }
    @IBAction func a_matureButton(sender: AnyObject) {
        self.imageName = "text_box_mature_oak.png"
        self.buttonState = true
        self.buttonImage = "oakFLOWER.png"
        
    }
    
    @IBAction func a_snagButton(sender: AnyObject) {
        self.imageName = "text_box_oaksnag.png"
        self.buttonImage = "NoImage.png"
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! PopupModalView
        dvc.newImage = UIImage(named:self.imageName)
        dvc.buttonState = self.buttonState
        dvc.buttonImage = UIImage(named:self.buttonImage)
        dvc.zoomImageName = self.zoomImageName
        dim(.In, alpha: dimLevel, speed: dimSpeed)

    }
    

    
    @IBAction func unwindFromSecondary(segue: UIStoryboardSegue) {
        dim(.Out, speed: dimSpeed)
    }
}