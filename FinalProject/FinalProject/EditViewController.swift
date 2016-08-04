//
//  EditViewController.swift
//  FinalProject
//
//  Created by Neil Patel on 7/30/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class EditViewController: UIViewController{
    
    var name:String?
    var commit:(String->Void)?
    var commitGrid:([[Int]]->Void)?
    var cells = [[Int]]()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gridView: GridView!
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        //if the user changes the grid and hits cancel button, an alert will pop up to confirm the action
        if StandardEngine.sharedInstance.changesDetect{
            
            let alert = UIAlertController(title: "Quit Without Saving", message: "Are you sure you want to quit without saving?", preferredStyle: UIAlertControllerStyle.Alert)
            //add cancel button action
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Quit", style: UIAlertActionStyle.Default, handler: {(action) -> Void in self.navigationController!.popViewControllerAnimated(true)}))
            
            let op = NSBlockOperation {
                self.presentViewController(alert, animated: true, completion: nil)
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }else{
            navigationController!.popViewControllerAnimated(true)
        }
        //clear the changes detecter
        StandardEngine.sharedInstance.changesDetect = false

    }
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
        let filteredArray = StandardEngine.sharedInstance.grid.cells.filter{$0.state.isLiving()}.map{return $0.position}
        
        for i in filteredArray{
            cells.append([i.row, i.col])
        }
        
        guard let newText = nameTextField.text, commit = commit
            else { return }
        commit(newText)
        guard let anothercommit = commitGrid else { return }
        anothercommit(cells)
        
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
        
        //set up the observer which updates the grid in the embed view when gets called
        let s = #selector(EditViewController.watchForNotifications(_:))
        let c = NSNotificationCenter.defaultCenter()
        c.addObserver(self, selector: s, name: "updateGridInEmbedView", object: nil)
    }
    
    func watchForNotifications(notification:NSNotification){
        gridView.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
