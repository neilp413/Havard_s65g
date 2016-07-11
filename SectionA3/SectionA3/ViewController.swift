//
//  ViewController.swift
//  SectionA3
//
//  Created by Neil Patel on 7/6/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    enum color: String{
        case red = "red"
        case blue
        
        
        
        
        func nextColor() ->color{
            switch(self){
            case.red:
                    return blue
            case.blue:
                    return red
            }
        }
        
        
        
        mutating func someColor()
        
    }
    
}

