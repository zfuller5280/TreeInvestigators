//
//  CheckListViewController.swift
//  TreeInvestigators_iPad
//
//  Created by Zach Fuller on 6/30/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.
//


import UIKit

class CheckListController: UIViewController, UITableViewDelegate, UITableViewDataSource, Dimmable{
        

    @IBOutlet weak var checklistView: UIView!
    @IBOutlet weak var closeButton: UIBarButtonItem!

    @IBOutlet weak var tableView: UITableView!

    
    
    var array: [String] = [ ]
    var checkStatus = Array(count: 1, repeatedValue:0)
    var arrayRow: Int = 0

    
    let dimLevel: CGFloat = 0.45
    let dimSpeed: Double = 0.5
    
    var labelArray =    [   ["Seed","Find a seed or a fuit, berry, cone, or nut"],
                            ["Seedling","Has a root, stem, and at least 1 leaf/needle","Is normally less than 2 feet tall","Does NOT have seeds or flowers on it"],
                            ["Sapling","Has a bendable trunk","Has a thin trunk","Does NOT have seeds or flowers on it"],
                            ["Mature Tree","May have flowers, fruit, berries, cones, or nuts","Has a thick trunk","Is usually tall"],
                            ["Snag or Dead Tree","A standing tree (snag)","A fallen or cut dead tree"]
                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checklistView.layer.cornerRadius = 10
        checklistView.layer.borderColor = UIColor.blackColor().CGColor
        checklistView.layer.borderWidth = 0.25
        checklistView.layer.shadowColor = UIColor.blackColor().CGColor
        checklistView.layer.shadowOpacity = 0.6
        checklistView.layer.shadowRadius = 15
        checklistView.layer.shadowOffset = CGSize(width: 5, height: 5)
        checklistView.layer.masksToBounds = false
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.checkStatus = [Int](count: self.array.count, repeatedValue: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func closeBtnClicked(sender: AnyObject) {
        print("cancel")
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            print("cancel")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = ("\u{2B1C} \(self.array[indexPath.row])")
        cell.textLabel?.font = UIFont(name: "Marker Felt",size:18)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if self.checkStatus[indexPath.row] == 0 {
            cell.textLabel?.text = ("\u{2611} \(self.array[indexPath.row])")
            self.checkStatus[indexPath.row] = 1
            let oldLabel = checkTextArray[arrayRow][indexPath.row + 1]
            let oldLabelArr = oldLabel.characters.split{$0 == " "}.map(String.init)
            let newLabel = String("\u{2611} \(oldLabelArr.dropFirst().joinWithSeparator(" "))")
            checkTextArray[arrayRow][indexPath.row + 1] = newLabel
            
        }
            
        else{
           cell.textLabel?.text = ("\u{2B1C} \(self.array[indexPath.row])")
            self.checkStatus[indexPath.row] = 0
            //cvc.checkArray[arrayRow] = self.checkStatus
            let oldLabel = checkTextArray[arrayRow][indexPath.row + 1]
            let oldLabelArr = oldLabel.characters.split{$0 == " "}.map(String.init)
            let newLabel = String("\u{2B1C} \(oldLabelArr.dropFirst().joinWithSeparator(" "))")
            checkTextArray[arrayRow][indexPath.row + 1] = newLabel
            
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    

    
    @IBAction func unwindFromSecondary(segue: UIStoryboardSegue) {
        dim(.Out, speed: dimSpeed)
    }
    
}