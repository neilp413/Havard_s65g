//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Neil Patel on 7/27/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var aliveTextField: UITextField!
    @IBOutlet weak var bornTextField: UITextField!
    @IBOutlet weak var emptyTextField: UITextField!
    @IBOutlet weak var diedTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = #selector(StatisticsViewController.watchForNotifications(_:))
        let c = NSNotificationCenter.defaultCenter()
        c.addObserver(self, selector: s, name: "setEngineStaticsNotification", object: nil)
        
        diedTextField.text = String(StandardEngine.sharedInstance.grid.died)
        aliveTextField.text = String(StandardEngine.sharedInstance.grid.alive)
        bornTextField.text = String(StandardEngine.sharedInstance.grid.born)
        emptyTextField.text = String(StandardEngine.sharedInstance.grid.empty)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForNotifications(notification:NSNotification){
        diedTextField.text = String(StandardEngine.sharedInstance.grid.died)
        aliveTextField.text = String(StandardEngine.sharedInstance.grid.alive)
        bornTextField.text = String(StandardEngine.sharedInstance.grid.born)
        emptyTextField.text = String(StandardEngine.sharedInstance.grid.empty)
    }
 
}
