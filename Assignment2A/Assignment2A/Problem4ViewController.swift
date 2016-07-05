//
//  Proble4mViewController.swift
//  Assignment2A
//
//  Created by Neil Patel on 6/29/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

let heightP4=10
let widthP4=10

class Problem4ViewController: UIViewController {
    
    //2D Array holding the cell
    var cellsP4:Array<Array<Bool>> = Array(count: heightP4, repeatedValue: Array(count: widthP4, repeatedValue: false))
    
    @IBOutlet weak var Problem4TextView: UITextView!
    
    @IBAction func Problem4Button(sender: UIButton)
    {
        //Setting up the values for the array
        for row in 0..<heightP4
        {
            for col in 0..<widthP4
            {
                if arc4random_uniform(3)==1
                {
                    cellsP4[row][col]=true
                }
            }
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Problem 4"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
