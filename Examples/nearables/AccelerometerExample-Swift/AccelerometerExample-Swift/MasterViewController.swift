//
//  MasterViewController.swift
//  AccelerometerExample-Swift
//
//  Created by Grzegorz Krukiewicz-Gacek on 05.01.2015.
//  Copyright (c) 2015 Estimote Inc. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, ESTNearableManagerDelegate {
    
    var nearables:Array<ESTNearable>!
    var nearableManager:ESTNearableManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nearables = []
        nearableManager = ESTNearableManager()
        nearableManager.delegate = self
        nearableManager .startRangingForType(ESTNearableType.All)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let selectedNearable = nearables[indexPath.row] as ESTNearable
                (segue.destinationViewController as DetailViewController).nearable = selectedNearable
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearables.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let nearable = nearables[indexPath.row] as ESTNearable
        cell.textLabel.text = nearable.nameForType(nearable.type)
        cell.detailTextLabel!.text = nearable.identifier
        return cell
    }
    
    // MARK: - ESTNearableManager delegate
    
    func nearableManager(manager: ESTNearableManager!, didRangeNearables nearables: [AnyObject]!, withType type: ESTNearableType) {
        
        self.nearables = nearables as Array<ESTNearable>
        tableView.reloadData()
    }
}

