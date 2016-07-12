//
//  ViewController.swift
//  Assignment3
//
//  Created by Neil Patel on 7/9/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Grid: GridView!
    @IBAction func Iterate(sender: UIButton) {
        let obj = GridView()
        Grid.grid = obj.step(Grid.rows, vertical: Grid.cols, cells: Grid.grid)
        Grid.setNeedsDisplay()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

