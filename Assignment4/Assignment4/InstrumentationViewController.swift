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
    
    @IBOutlet weak var rowTextField: UITextField!
    
    @IBAction func updateRowTextField(sender: UITextField) {
        if let text = sender.text,
            let r = Int(text)  {
            StandardEngine.sharedInstance.row = r
        }
        else  {
            StandardEngine.sharedInstance.row = 0
        }
    }
    
    @IBAction func Switch(sender: UISwitch) {
    }
    
    @IBAction func rowIncrement(sender: UIStepper) {
        var r: Int = Int(rowTextField.text!)!
            rowTextField.text = String(r += 10)
    }
    
    @IBAction func rowDecrement(sender: UIStepper) {
        StandardEngine.sharedInstance.row -= 10
    }
    @IBAction func columnIncrement(sender: UIStepper) {
        StandardEngine.sharedInstance.col += 10
    }
    @IBAction func columnDecrement(sender: AnyObject) {
        StandardEngine.sharedInstance.col -= 10
    }
}
