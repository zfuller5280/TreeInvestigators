//
//  PopupModalView.swift
//  TreeInvestigators_iPad
//
//  Created by Zach Fuller on 6/9/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.



import UIKit

class PopupModalView: UIViewController, Dimmable {
    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var textImage: UIImageView!
    @IBOutlet weak var zoomButton: UIButton!
    var newImage: UIImage!
    var buttonState: Bool!
    var buttonImage: UIImage!

    var zoomImageName: String!

    let dimLevel: CGFloat = 0.45
    let dimSpeed: Double = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        popupView.layer.borderColor = UIColor.blackColor().CGColor
        popupView.layer.borderWidth = 0.25
        popupView.layer.shadowColor = UIColor.blackColor().CGColor
        popupView.layer.shadowOpacity = 0.6
        popupView.layer.shadowRadius = 15
        popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popupView.layer.masksToBounds = false
        
        textImage.image = newImage
        zoomButton.enabled = buttonState
        zoomButton.setImage(buttonImage, forState: .Normal)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "closeBox"{
            let dvc = segue.destinationViewController as! ZoomViewController
            dvc.zoomImageName = zoomImageName
        }

    }
    
    @IBAction func unwindFromSecondary(segue: UIStoryboardSegue) {
        dim(.Out, speed: dimSpeed)
         }
    
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
        
}