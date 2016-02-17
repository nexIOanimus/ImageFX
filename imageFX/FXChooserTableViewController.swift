//
//  FXChooserTableViewController.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/10/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit

class FXChooserTableViewController: UITableViewController {
    
    let fxGroups : [FXGroup] = FXGroup.getFXGroups()
        
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
        return fxGroups.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : FXGroupCell = tableView.dequeueReusableCellWithIdentifier("fxCell", forIndexPath: indexPath) as! FXGroupCell
        let fxGroup : FXGroup = fxGroups[indexPath.row]
        
        cell.mainLabel.text = fxGroup.name
        
        /*
        cell = FXGroupCell(frame: cell.frame)
        
        let fxCell = cell as! FXGroupCell
        fxCell.mainLabel.text = "Hello."
        */
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = FXChooserDetailTableViewController()
        vc.fxUnits = FXUnit.getFXListForGroupName(fxGroups[indexPath.row].name)
        showViewController(vc, sender: nil)
    }
    
    
    
}
