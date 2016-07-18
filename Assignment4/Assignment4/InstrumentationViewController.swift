//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Neil Patel on 7/14/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var rowText: UITextField!
    @IBOutlet weak var ColumnText: UITextField!
    
    @IBOutlet weak var rowStep: UIStepper!
    @IBOutlet weak var columnStep: UIStepper!
    
    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var refreshSwitch: UISwitch!
    
    @IBAction func rowStep(sender: UIStepper) {
        StandardEngine.sharedInstance.row = Int(rowStep.value)
        rowText.text = String(Int(StandardEngine.sharedInstance.row))
    }
    
    @IBAction func columnStep(sender: UIStepper) {
        StandardEngine.sharedInstance.col = Int(columnStep.value)
        ColumnText.text = String(Int(StandardEngine.sharedInstance.col))

    }
    
    @IBAction func rateSlider(sender: AnyObject) {
        StandardEngine.sharedInstance.refreshRate = NSTimeInterval(rateSlider.value)
    }
    
    @IBAction func refreshSwitch(sender: UISwitch) {
        if sender.on{
            StandardEngine.sharedInstance.refreshRate = NSTimeInterval(rateSlider.value)
        }
        else{
            StandardEngine.sharedInstance.refreshTimer?.invalidate()
        }
    }
    
}
