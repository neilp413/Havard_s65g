//
//  TableViewController.swift
//  FinalProject
//
//  Created by Neil Patel on 7/29/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class TableViewController:UITableViewController{
    
    var names = [String]()
    var gridSwitch =  [[[Int]]]()
    
    static var _sharedTable = TableViewController()
    static var sharedTable: TableViewController { get { return _sharedTable } }
    
    @IBAction func addButton(sender: UIBarButtonItem) {
        TableViewController.sharedTable.names.append("Add new name...")
        TableViewController.sharedTable.gridSwitch.append([])
        
        let itemRow = TableViewController.sharedTable.names.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up observer to reload the data of the table view
        let s = #selector(TableViewController.dataReload(_:))
        let c = NSNotificationCenter.defaultCenter()
        c.addObserver(self, selector: s, name: "TableViewReloadData", object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReload(notification:NSNotification) {
        self.tableView.reloadData()
        self.tableView.setNeedsDisplay()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewController.sharedTable.names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell")
            else {
                preconditionFailure("missing TableViewCell reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("Something is wrong.")
        }
        nameLabel.text = TableViewController.sharedTable.names[row]
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            TableViewController.sharedTable.names.removeAtIndex(indexPath.row)
            TableViewController.sharedTable.gridSwitch.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        StandardEngine.sharedInstance.changesDetect = false
        let editingRow = (sender as! UITableViewCell).tag
        let editingString = TableViewController.sharedTable.names[editingRow]
        guard let editingVC = segue.destinationViewController as? EditViewController
            else {
                preconditionFailure("Something went wrong")
        }
        editingVC.name = editingString
        editingVC.commit = {
            TableViewController.sharedTable.names[editingRow] = $0
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                  withRowAnimation: .Automatic)
        }
        editingVC.commitGrid = {
            TableViewController.sharedTable.gridSwitch[editingRow] = $0
        }

        
        //set up the size of the grid according to the content of the row selected
        let max = TableViewController.sharedTable.gridSwitch[editingRow].flatMap{$0}.maxElement()
        if let safeMax = max {
            StandardEngine.sharedInstance.rows = (safeMax % 10 != 0) ? (safeMax/10+1)*10 : safeMax
            StandardEngine.sharedInstance.cols = (safeMax % 10 != 0) ? (safeMax/10+1)*10 : safeMax
        }
        
        //set the cells on
        let medium:[(Int,Int)] = TableViewController.sharedTable.gridSwitch[editingRow].map{return ($0[0], $0[1])}
        GridView().points = medium
        
        //update grid in simulation tab
        if let delegate = StandardEngine.sharedInstance.delegate {
            delegate.engineDidUpdate(StandardEngine.sharedInstance.grid)
        }
        
        //update the text fields of row and col in the instrumentation tab
        NSNotificationCenter.defaultCenter().postNotificationName("updateRowAndColText", object: nil, userInfo: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("turnOffTimedRefresh", object: nil, userInfo: nil)
        
    }
}

