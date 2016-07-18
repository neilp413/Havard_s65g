//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Neil Patel on 7/14/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController,EngineDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.sharedInstance.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StepButton(sender: UIButton) {
        StandardEngine.sharedInstance.step()
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }
}
