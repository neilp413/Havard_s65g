//
//  ViewController.swift
//  class4test
//
//  Created by Neil Patel on 6/29/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var TextView: UITextView!
    @IBAction func ButtonClicked(sender: AnyObject) {
        print("We were clicked")
        TextView.text = "clicked"
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

