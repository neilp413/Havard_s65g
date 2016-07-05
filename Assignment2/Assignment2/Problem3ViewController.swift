//
//  Problem3ViewController.swift
//  Assignment2A
//
//  Created by Neil Patel on 6/29/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

//height and width of 2D array
let heightP3=10
let widthP3=10

class Problem3ViewController: UIViewController {
    
    //2D Array holding the cells
    var cellsP3:Array<Array<Bool>>=Array(count: heightP3, repeatedValue: Array(count: widthP3, repeatedValue: false))
    
    @IBOutlet weak var Problem3TextView: UITextView!
    
    @IBAction func Problem3Button(sender: UIButton)
    {
        var countBeforeP3=0
        
        //Sets up the arrray with the active cells and counts the amount of active cells before on iteration
        for row in 0..<widthP3
        {
            for col in 0..<heightP3
            {
                if arc4random_uniform(3)==1
                {
                    cellsP3[row][col]=true
                    countBeforeP3+=1
                }
            }
        }
        
        //Goes through one iteration
        cellsP3=step(cellsP3)
        
        //Getting the count of the number of alive cells after one iteration
        var countAfterP3=0
        
        for row in 0..<widthP3
        {
            for col in 0..<widthP3
            {
                if(cellsP3[row][col])
                {
                    countAfterP3+=1
                }
            }
        }
        
        //Displays the amount of active cells before and after one iteration
        Problem3TextView.text = "Active cells before: \(countBeforeP3) \nActive cells after: \(countAfterP3)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Problem 3"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
