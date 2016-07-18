//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Neil Patel on 7/12/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegateProtocol {

    @IBOutlet weak var grid: GridView!
    
    @IBAction func run(sender: AnyObject) {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
    }
    
    
    
    func engineDidUpdate(withGrid: GridProtocol) {
        grid.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StandardEngine.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

