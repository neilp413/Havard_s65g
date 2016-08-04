//
//  Instrumentation.swift
//  FinalProject
//
//  Created by Neil Patel on 7/27/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController{
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var rowTextField: UITextField!
    @IBOutlet weak var columnTextField: UITextField!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var columnStepper: UIStepper!
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var timeSwitch: UISwitch!
    
    @IBAction func reloadButton(sender: UIButton) {
        //download and parse the JSON file and then update the table view
        TableViewController.sharedTable.names = []
        TableViewController.sharedTable.gridSwitch = []
        
        //if the user enters an invalid url, pop up an alert view
        if let url = urlTextField.text{
            guard let requestURL: NSURL = NSURL(string: url) else {
                let alertController = UIAlertController(title: "URL Error", message:
                    "Please enter a valid url", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(urlRequest) {
                (data, response, error) -> Void in
                
                let httpResponse = response as?NSHTTPURLResponse
                let statusCode = httpResponse?.statusCode
                if let safeStatusCode = statusCode{
                    if (safeStatusCode == 200) {
                        do{
                            
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? [AnyObject]
                            for i in 0...json!.count-1 {
                                let pattern = json![i]
                                let collection = pattern as! Dictionary<String, AnyObject>
                                TableViewController.sharedTable.names.append(collection["title"]! as! String)
                                let arr = collection["contents"].map{return $0 as! [[Int]]}
                                TableViewController.sharedTable.gridSwitch.append(arr!)
                            }
                        }catch {
                            print("Error with Json: \(error)")
                            TableViewController.sharedTable.names = []
                            TableViewController.sharedTable.gridSwitch = []
                            NSNotificationCenter.defaultCenter().postNotificationName("TableViewReloadData", object: nil, userInfo: nil)
                        }
                        
                        //put the table reload process into the main thread to reload it right away
                        let op = NSBlockOperation {
                            NSNotificationCenter.defaultCenter().postNotificationName("TableViewReloadData", object: nil, userInfo: nil)
                        }
                        NSOperationQueue.mainQueue().addOperation(op)
                        
                    }
                    else{
                        //put the pop up window in the main thread for HTTP errors and then pop it up
                        let op = NSBlockOperation {
                            let alertController = UIAlertController(title: "Error", message:
                                "HTTP Error \(safeStatusCode): \(NSHTTPURLResponse.localizedStringForStatusCode(safeStatusCode))           Please enter a valid url", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                            TableViewController.sharedTable.names = []
                            TableViewController.sharedTable.gridSwitch = []
                            NSNotificationCenter.defaultCenter().postNotificationName("TableViewReloadData", object: nil, userInfo: nil)
                        }
                        NSOperationQueue.mainQueue().addOperation(op)
                    }
                }else{
                    //put the pop up window in the main thread for url errors and then pop it up
                    let op = NSBlockOperation {
                        let alertController = UIAlertController(title: "Error", message:
                            "Please check your url or your Internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        //clear the embed table view so that the app will not crash
                        TableViewController.sharedTable.names = []
                        TableViewController.sharedTable.gridSwitch = []
                        NSNotificationCenter.defaultCenter().postNotificationName("TableViewReloadData", object: nil, userInfo: nil)
                    }
                    NSOperationQueue.mainQueue().addOperation(op)
                }
            }
            task.resume()
        }
    }
    
    @IBAction func rowStepper(sender: UIStepper) {
        StandardEngine.sharedInstance.rows = Int(rowStepper.value)
        rowTextField.text = String(Int(StandardEngine.sharedInstance.rows))
        
        //create a new grid when row changes
        StandardEngine.sharedInstance.grid = Grid(StandardEngine.sharedInstance.rows, StandardEngine.sharedInstance.cols)
        
        //post notification to update the grid in the embed view
        NSNotificationCenter.defaultCenter().postNotificationName("updateGridInEmbedView", object: nil, userInfo: nil)
    }
    
    @IBAction func columnStepper(sender: UIStepper) {
        StandardEngine.sharedInstance.cols = Int(columnStepper.value)
        columnTextField.text = String(Int(StandardEngine.sharedInstance.cols))
        
        //create a new grid when col changes
        StandardEngine.sharedInstance.grid = Grid(StandardEngine.sharedInstance.rows, StandardEngine.sharedInstance.cols)
        
        //post notification to update the grid in the embed view
        NSNotificationCenter.defaultCenter().postNotificationName("updateGridInEmbedView", object: nil, userInfo: nil)

    }
    
    @IBAction func timeSwitch(sender: UISwitch) {
        if sender.on{
            StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(rateSlider.value)
            StandardEngine.sharedInstance.refreshRate = rateSlider.value
            StandardEngine.sharedInstance.isPaused = false
        }
        else{
            StandardEngine.sharedInstance.refreshTimer?.invalidate()
            StandardEngine.sharedInstance.isPaused = true
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSwitch.setOn(false, animated: true)
        
        //set up observer so that when the row and col get changed the numbers in the textfields will get updated
        let s = #selector(InstrumentationViewController.watchForNotifications(_:))
        let c = NSNotificationCenter.defaultCenter()
        c.addObserver(self, selector: s, name: "updateRowAndColText", object: nil)
        
        //set up observer which will switch the timed refresh
        let sel = #selector(InstrumentationViewController.switchTimedRefresh(_:))
        c.addObserver(self, selector: sel, name: "switchTimedRefresh", object: nil)
        
        //set up observer which will turn off the timed refresh when user segues out to the editter grid view
        let selc = #selector(InstrumentationViewController.turnOffTimedRefresh(_:))
        c.addObserver(self, selector: selc, name: "turnOffTimedRefresh", object: nil)
        
        //take care of the steppers and textfields
        rowStepper.value = Double(StandardEngine.sharedInstance.rows)
        columnStepper.value = Double(StandardEngine.sharedInstance.cols)
        rowStepper.stepValue = 10
        columnStepper.stepValue = 10
        //set the rows and cols' minimum values to 10 to avoid the problem of not showing the grid and presenting error message
        rowStepper.minimumValue = 10
        columnStepper.minimumValue = 10
        columnTextField.text = String(Int(StandardEngine.sharedInstance.cols))
        rowTextField.text = String(Int(StandardEngine.sharedInstance.rows))
        
        if let delegate = StandardEngine.sharedInstance.delegate {
            delegate.engineDidUpdate(StandardEngine.sharedInstance.grid)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("setEngineStaticsNotification", object: nil, userInfo: nil)

    }
    
    func watchForNotifications(notification:NSNotification){
        rowStepper.value = Double(StandardEngine.sharedInstance.rows)
        columnStepper.value = Double(StandardEngine.sharedInstance.cols)
        columnTextField.text = String(Int(StandardEngine.sharedInstance.cols))
        rowTextField.text = String(Int(StandardEngine.sharedInstance.rows))
    }
    
    func switchTimedRefresh(notification:NSNotification){
        if timeSwitch.on{
            StandardEngine.sharedInstance.refreshTimer?.invalidate()
            timeSwitch.setOn(false, animated: true)
            StandardEngine.sharedInstance.isPaused = true
        }
        else{
            timeSwitch.setOn(true, animated: true)
            StandardEngine.sharedInstance.isPaused = false
        }
    }
    
    func turnOffTimedRefresh(notification:NSNotification){
        if timeSwitch.on{
            StandardEngine.sharedInstance.refreshTimer?.invalidate()
            timeSwitch.setOn(false, animated: true)
            StandardEngine.sharedInstance.isPaused = true
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}
