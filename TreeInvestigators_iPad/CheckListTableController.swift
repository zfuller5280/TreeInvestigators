//
//  CheckListTableController.swift
//  TreeInvestigators_iPad
//
//  Created by Steve Schaeffer on 6/30/16.
//  Copyright © 2016 Zach Fuller. All rights reserved.
//
import UIKit
import Foundation


var checkTextArray = [   ["Seed","\u{2B1C} Find a seed or a fuit, berry, cone, or nut"],
                ["Seedling","\u{2B1C} Has a root, stem, and at least 1 leaf/needle","\u{2B1C} Is normally less than 2 feet tall","\u{2B1C} Does NOT have seeds or flowers on it"],
                ["Sapling","\u{2B1C} Has a bendable trunk","\u{2B1C} Has a thin trunk","\u{2B1C} Does NOT have seeds or flowers on it"],
                ["Mature Tree","\u{2B1C} May have flowers, fruit, berries, cones, or nuts","\u{2B1C} Has a thick trunk","\u{2B1C} Is usually tall"],
                ["Snag or Dead Tree","\u{2B1C} A standing tree (snag)","\u{2B1C} A fallen or cut dead tree"]
]

class CheckListTableController: UITableViewController {
    
    var array :[Array<String>] = [ ]
    
    @IBOutlet weak var checklistView: UITableView!

 
    override func viewDidLoad() {
        array = checkTextArray
        super.viewDidLoad()


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count - 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell;
        cell.textLabel?.text = array[indexPath.section][indexPath.row + 1]
        cell.textLabel?.font = UIFont(name: "Marker Felt",size:18)
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return array[section][0]
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Marker Felt", size: 24)!
        header.textLabel?.textColor = UIColor.lightGrayColor()
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        array = checkTextArray
        print(self.array)
        tableView.reloadData()

    }
    
    func generateImage(tableView:UITableView) ->UIImage{
        //Image generated from extension located in UITableView+Additions.swift
        let image = tableView.screenshot
        return image!
    }
    
}



