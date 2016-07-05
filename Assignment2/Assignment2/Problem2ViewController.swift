//
//  Problem2ViewController.swift
//  Assignment2A
//
//  Created by Neil Patel on 6/29/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

//height and width of 2D array
let heightP2=10
let widthP2=10

class Problem2ViewController: UIViewController {
    
    
    //2D Array holding the cells
    var cellsP2:Array<Array<Bool>>=Array(count: heightP2, repeatedValue: Array(count: widthP2, repeatedValue: false))
    
    @IBOutlet weak var Problem2TextView: UITextView!
    
    @IBAction func Problem2Button(sender: UIButton) 
    {
        var countBeforeP2=0
        
        //Sets up the array with the active cels and counts the amount of active cells before one iteration
        for row in 0..<widthP2{
            for col in 0..<heightP2{
                if arc4random_uniform(3)==1{
                    cellsP2[row][col]=true
                    countBeforeP2+=1
                }
            }
        }
    
        
        //Go through one iteration
        for row in 0..<widthP2
        {
            for col in 0..<heightP2
            {
                var countNeighbor=0
                
                //checks if row-1 has active cell
                switch row-1{
                    
                //checks if row-1 is valid in 2D array
                case _ where row-1<0:
                    //checks if column-1 has active cell
                    switch col-1{
                    //checks if col-1 is valid in 2D array
                    case _ where col-1<0:
                        if cellsP2[widthP2-1][heightP2-1]{
                            countNeighbor+=1
                        }
                    //if col-1 is valid
                    default:
                        if cellsP2[widthP2-1][col-1]{
                            countNeighbor+=1
                        }
                    }
                    
                    //checks if column+1 has active cell
                    switch col+1{
                    //checks if col+1 is valid in 2D array
                    case _ where col+1>=heightP2:
                        if cellsP2[widthP2-1][0]{
                            countNeighbor+=1
                        }
                    //if col+1 is valid
                    default:
                        if cellsP2[widthP2-1][col+1]{
                            countNeighbor+=1
                        }
                        
                    }
                    //checks for column has avtive cell
                    if cellsP2[widthP2-1][col]{
                        countNeighbor+=1
                    }
                //if row-1 is valid
                default:
                    //checks if column-1 has active cell
                    switch col-1{
                    //checks if col-1 is valid in 2D array
                    case _ where col-1<0:
                        if cellsP2[row-1][heightP2-1]{
                            countNeighbor+=1
                        }
                    //if col-1 is valid
                    default:
                        if cellsP2[row-1][col-1]{
                            countNeighbor+=1
                        }
                    }
                    
                    //checks if column+1 has active cell
                    switch col+1{
                    //checks if col+1 is valid in 2D array
                    case _ where col+1>=heightP2:
                        if cellsP2[row-1][0]{
                            countNeighbor+=1
                        }
                    //if row-1 is valid
                    default:
                        if cellsP2[row-1][col+1]{
                            countNeighbor+=1
                        }
                        
                    }
                    //checks for column has avtive cell
                    if cellsP2[row-1][col]{
                        countNeighbor+=1
                    }
                }
                
                //checks if row has active cell
                
                //checks if column-1 has active cell
                switch col-1{
                //checks if col-1 is valid in 2D array
                case _ where col-1<0:
                    if cellsP2[row][heightP2-1]{
                        countNeighbor+=1
                    }
                //if col-1 is valid
                default:
                    if cellsP2[row][col-1]{
                        countNeighbor+=1
                    }
                }
                
                //checks if column+1 has active cell
                switch col+1{
                //checks if col+1 is valid in 2D array
                case _ where col+1>=heightP2:
                    if cellsP2[row][0]{
                        countNeighbor+=1
                    }
                //if col+1 is valid
                default:
                    if cellsP2[row][col+1]{
                        countNeighbor+=1
                    }
                    
                }
                //checks for column has avtive cell
                if cellsP2[row][col]{
                    countNeighbor+=1
                }
                
                //checks if row+1 has active cell
                switch row+1{
                    
                //checks if row+1 is valid in 2D array
                case _ where row+1>=widthP2:
                    //checks if column-1 has active cell
                    switch col-1{
                    //checks if col-1 is valid in 2D array
                    case _ where col-1<0:
                        if cellsP2[0][heightP2-1]{
                            countNeighbor+=1
                        }
                    //if col-1 is valid
                    default:
                        if cellsP2[0][col-1]{
                            countNeighbor+=1
                        }
                    }
                    
                    //checks if column+1 has active cell
                    switch col+1{
                    //checks if col+1 is valid in 2D array
                    case _ where col+1>=heightP2:
                        if cellsP2[0][0]{
                            countNeighbor+=1
                        }
                    //if col+1 is valid
                    default:
                        if cellsP2[0][col+1]{
                            countNeighbor+=1
                        }
                        
                    }
                    //checks for column has avtive cell
                    if cellsP2[0][col]{
                        countNeighbor+=1
                    }
                //if row-1 is valid
                default:
                    //checks if column-1 has active cell
                    switch col-1{
                    //checks if col-1 is valid in 2D array
                    case _ where col-1<0:
                        if cellsP2[row+1][heightP2-1]{
                            countNeighbor+=1
                        }
                    //if col-1 is valid
                    default:
                        if cellsP2[row+1][col-1]{
                            countNeighbor+=1
                        }
                    }
                    
                    //checks if column+1 has active cell
                    switch col+1{
                    //checks if col+1 is valid in 2D array
                    case _ where col+1>=heightP2:
                        if cellsP2[row+1][0]{
                            countNeighbor+=1
                        }
                    //if row+1 is valid
                    default:
                        if cellsP2[row+1][col+1]{
                            countNeighbor+=1
                        }
                        
                    }
                    //checks for column has avtive cell
                    if cellsP2[row+1][col]{
                        countNeighbor+=1
                    }
                }
                
                //Checking the rules of the cells
                
                //Any live cell with fewer than two live neighbors dies or stays, as if caused by under-population.
                if countNeighbor<2
                {
                    cellsP2[row][col]=false
                }
                //Any live cell with two or three live neighbors lives on to the next generation.
                if cellsP2[row][col] && (countNeighbor==2||countNeighbor==3)
                {
                    cellsP2[row][col]=true
                }
                //Any live cell with more than three live neighbors dies, as if by overcrowding.
                if cellsP2[row][col] && countNeighbor>3
                {
                    cellsP2[row][col]=false
                }
                //Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
                if !cellsP2[row][col] && countNeighbor==3
                {
                    cellsP2[row][col]=true
                }
            }
        }
        
        //Getting the count of the number of alive cells after one iteration
        var countAfterP2=0
        
        for row in 0..<widthP2
        {
            for col in 0..<widthP2
            {
                if(cellsP2[row][col])
                {
                    countAfterP2+=1
                }
            }
        }
        
        //Displays the active cells before and after one iteration
        Problem2TextView.text = "Active cells before: \(countBeforeP2) \nActive cells after: \(countAfterP2)"
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Problem 2"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
