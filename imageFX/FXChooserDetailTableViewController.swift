//
//  FXChooserDetailTableViewController.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/10/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit

class FXChooserDetailTableViewController: UITableViewController {
    
    var fxUnits : [FXUnit] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib.init(nibName: "FXChooserCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "fxCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fxUnits.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fxCell", forIndexPath: indexPath) as! FXGroupCell
        
        cell.mainLabel.text = fxUnits[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.currentFX = fxUnits[indexPath.row]
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
