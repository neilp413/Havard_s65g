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
        rowTextField.text = String(StandardEngine.sharedInstance.row)
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
    
    
    @IBAction func rowIncrement(sender: UIStepper) {
        if let text = rowTextField.text{
            let r = Int(text)
            rowTextField.text = String(r! + 10)
        }
    }
    
    @IBAction func rowDecrement(sender: UIStepper) {
        
    }

}
