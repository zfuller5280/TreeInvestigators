//
//  SecondViewController.swift
//  TreeInvestigators_iPad
//
//  Created by Zach Fuller on 6/9/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.
//

import UIKit
import MobileCoreServices

class SecondViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIAlertViewDelegate,UIPopoverPresentationControllerDelegate, Dimmable{
    
    let dimLevel: CGFloat = 0.45
    let dimSpeed: Double = 0.5

    @IBOutlet weak var seedButton: UIButton!
    @IBOutlet weak var seedlingButton: UIButton!
    @IBOutlet weak var saplingButton: UIButton!
    @IBOutlet weak var matureButton: UIButton!
    @IBOutlet weak var snagButton: UIButton!
    
    @IBOutlet weak var a_SeedPicture: UIImageView!
    @IBOutlet weak var a_seedlingPicture: UIImageView!
    @IBOutlet weak var a_maturePicture: UIImageView!
    @IBOutlet weak var a_saplingPicture: UIImageView!
    @IBOutlet weak var a_snagPicture: UIImageView!
    
    
    @IBOutlet weak var layoutView: UIView!

    
    @IBOutlet weak var saveButtonImage: UIButton!
    @IBOutlet weak var clearButtonImage: UIButton!

    
    var newMedia: Bool?
    var imageToChange: UIImageView!
    
    var textArray: [String] = [ ]
    var checkStatus = Array(count: 1, repeatedValue:0)
    var checkArray = Array(count: 5, repeatedValue:[])
    var arrayRow: Int = 0

    
    var picker:UIImagePickerController?=UIImagePickerController()
    var popover:UIPopoverPresentationController?=nil
    
    @IBAction func seedButtonClicked(sender: AnyObject) {
        btnImagePickerClicked(seedButton)
        imageToChange = a_SeedPicture
        self.textArray = ["Find a seed or a fruit, berry, cone, or nut"]
        self.arrayRow = 0

    }
    
    @IBAction func seedlingButtonClicked(sender: AnyObject) {
        btnImagePickerClicked(seedlingButton)
        imageToChange = a_seedlingPicture
        self.textArray = ["Has a root, stem, and at least 1 leaf/needle","Is normally less than 2 feet tall","Does NOT have seeds or flowers on it"]
        self.arrayRow = 1
    }
    @IBAction func saplingButtonClicked(sender: AnyObject) {
        btnImagePickerClicked(saplingButton)
        imageToChange = a_saplingPicture
        self.textArray = ["Has a bendable trunk","Has a thin trunk","Does NOT have seeds or flowers on it"]
        self.arrayRow = 2
    }
    
    
    @IBAction func snagButtonClicked(sender: AnyObject) {
        btnImagePickerClicked(snagButton)
        imageToChange = a_snagPicture
        self.textArray = ["A standing tree (snag)","A fallen or cut dead tree"]
        self.arrayRow = 4
    }
    
    @IBAction func matureButtonClicked(sender: AnyObject) {
        btnImagePickerClicked(matureButton)
        imageToChange = a_maturePicture
        self.textArray = ["May have flowers, fruit, berries, cones, or nuts","Has thick trunk","Is usually tall"]
        self.arrayRow = 3
    }

    func btnImagePickerClicked(button: UIButton)
    {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
        {
            UIAlertAction in
            self.openCamera(button)
        }
        let gallaryAction = UIAlertAction(title: "Library", style: UIAlertActionStyle.Default)
        {
            UIAlertAction in
            self.openGallary(button)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        picker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            
            alert.popoverPresentationController?.sourceView = button.imageView
            alert.popoverPresentationController?.sourceRect = button.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .Any
            self.presentViewController(alert, animated: true, completion: nil)

        }

    }
    
    func openCamera(button: UIButton)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true,
                                       completion: nil)
            newMedia = true
        }
    }
    func openGallary(button: UIButton)
    {

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.modalPresentationStyle = .Popover
        let presentationController = imagePickerController.popoverPresentationController
        

        presentationController?.sourceView = button
        presentationController?.sourceRect = button.bounds
        presentationController?.permittedArrowDirections = .Any
        
        self.presentViewController(imagePickerController, animated: true) {}
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker .dismissViewControllerAnimated(true, completion: nil)
        self.imageToChange.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageToChange.contentMode = .ScaleAspectFill
        self.imageToChange.clipsToBounds = true
        
        let tvc = self.storyboard?.instantiateViewControllerWithIdentifier("seedCheckList") as! CheckListController!
        tvc.array = self.textArray
        tvc.arrayRow = self.arrayRow
        self.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(tvc!, animated:false,completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
        picker .dismissViewControllerAnimated(true, completion: nil)
    }


    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC,
                              animated: true,
                              completion: nil)
    }

    @IBAction func saveButton(sender: AnyObject) {
        
        /*
        let appDelegate = UIApplication.sharedApplication().delegate
        let saveView = UIView(frame: layoutView.frame)
        saveView.backgroundColor = UIColor.blackColor()
        saveView.alpha = 0.6
        appDelegate?.window!!.addSubview(saveView)
        */
        
        self.saveButtonImage.setImage(UIImage(named:"NoName.png"), forState: .Normal)
        self.clearButtonImage.setImage(UIImage(named:"NoName.png"), forState: .Normal)
        
        let image = layoutView.pb_takeSnapshot()
        
        self.saveButtonImage.setImage(UIImage(named:"save-icon-new-final.png"), forState: .Normal)
        self.clearButtonImage.setImage(UIImage(named:"clear_icon.png"), forState: .Normal)
        
        let cvc = self.storyboard?.instantiateViewControllerWithIdentifier("checklistTable") as! CheckListTableController!
        let checkImage = cvc.generateImage(cvc.tableView)
        
        let vc = UIActivityViewController(activityItems: [image, checkImage], applicationActivities: [])
        vc.popoverPresentationController?.sourceView = saveButtonImage.imageView
        vc.popoverPresentationController?.sourceRect = saveButtonImage.bounds
        

        presentViewController(vc, animated: true, completion: nil)
    
        
    }
    @IBAction func clearBtnClicked(sender: AnyObject) {
        a_SeedPicture.image = nil
        a_seedlingPicture.image = nil
        a_saplingPicture.image = nil
        a_maturePicture.image = nil
        a_snagPicture.image = nil
        
        checkTextArray = [   ["Seed","\u{2B1C} Find a seed or a fuit, berry, cone, or nut"],
                                 ["Seedling","\u{2B1C} Has a root, stem, and at least 1 leaf/needle","\u{2B1C} Is normally less than 2 feet tall","\u{2B1C} Does NOT have seeds or flowers on it"],
                                 ["Sapling","\u{2B1C} Has a bendable trunk","\u{2B1C} Has a thin trunk","\u{2B1C} Does NOT have seeds or flowers on it"],
                                 ["Mature Tree","\u{2B1C} May have flowers, fruit, berries, cones, or nuts","\u{2B1C} Has a thick trunk","\u{2B1C} Is usually tall"],
                                 ["Snag or Dead Tree","\u{2B1C} A standing tree (snag)","\u{2B1C} A fallen or cut dead tree"]
        ]
        
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIView {
    
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.mainScreen().scale);
        
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}






