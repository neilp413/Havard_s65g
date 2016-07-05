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
    
    //2D Array holding the cells
    var cellsP4:Array<Array<Bool>>=Array(count: heightP4, repeatedValue: Array(count: widthP4, repeatedValue: false))
    

    
    @IBOutlet weak var Problem4TextView: UITextView!
    
    @IBAction func Problem4Button(sender: UIButton)
    {
        var countBeforeP4=0
        
        //Sets up the array with active cells and counts the amount of active cells
        for row in 0..<heightP4
        {
            for col in 0..<widthP4
            {
                if arc4random_uniform(3)==1
                {
                    cellsP4[row][col]=true
                    countBeforeP4+=1
                }
            }
        }
        
        //Goes through one iteration
        cellsP4=step2(cellsP4)
        
        //Getting the count of the number of alive cells after one iteration
        var countAfterP4=0
        
        for row in 0..<widthP3
        {
            for col in 0..<widthP3
            {
                if(cellsP4[row][col])
                {
                    countAfterP4+=1
                }
            }
        }
        
        //Displays the amount of active cells before and after one iteration
        Problem4TextView.text="Active cells before: \(countBeforeP4)\nActive cells after: \(countAfterP4)"

        
    }
    
    /*Goes through an iteration of the game of life
    
      Param cells: the 2D array that holds the cells
     
      Return: a 2D array that holds the cells after an iteration
     
     */
    func step2(cells: Array<Array<Bool>>)->Array<Array<Bool>>
    {
        var arr=cells
        
        for row in 0..<heightP4
        {
            for col in 0..<widthP4
            {
                let cords = neighbors((row,col))
                var countNeighbors=0
                for count in cords
                {
                    if arr[count.0][count.1]
                    {
                        countNeighbors+=1
                    }
                }
                
                //Checking the rules of the cells
                
                //Any live cell with fewer than two live neighbors dies or stays, as if caused by under-population.
                if countNeighbors<2
                {
                    arr[row][col]=false
                }
                //Any live cell with two or three live neighbors lives on to the next generation.
                if arr[row][col] && (countNeighbors==2||countNeighbors==3)
                {
                    arr[row][col]=true
                }
                //Any live cell with more than three live neighbors dies, as if by overcrowding.
                if arr[row][col] && countNeighbors>3
                {
                    arr[row][col]=false
                }
                //Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
                if !arr[row][col] && countNeighbors==3
                {
                    arr[row][col]=true
                }
                
                
            }
        }
        
        return arr
    }
    
    /*Gets valid neighbors of a certain row and column
     
     Param cords: a tuple of the row and column to get the neigbhors
     
     Return: the array of valid neigbhors
     */
    func neighbors(cords: (Int,Int))->Array<(Int,Int)>
    {
        var arr=[(Int,Int)]()
        let row=cords.0
        let col=cords.1
        
        //collecting valid values of row-1
        switch row-1{
            
        //checks if row-1 is valid in 2D array
        case _ where row-1<0:
            //checks if column-1 is valid
            switch col-1{
            //checks if col-1 is valid in 2D array
            case _ where col-1<0:
                arr.append((heightP4-1,widthP4-1))
            //if col-1 is valid
            default:
                arr.append((heightP4-1,col-1))
            }
            
            //checks if column+1 is valid
            switch col+1{
            //checks if col+1 is valid in 2D array
            case _ where col+1>=widthP4:
                arr.append((heightP4-1,0))
            //if col+1 is valid
            default:
                arr.append((heightP4-1,col+1))
            }
            //adding col since valid
            arr.append((heightP4-1,col))
            
        //if row-1 is valid
        default:
            //checks if column-1 is valid
            switch col-1{
            //checks if col-1 is valid in 2D array
            case _ where col-1<0:
                arr.append((row-1,widthP4-1))
            //if col-1 is valid
            default:
                arr.append((row-1,col-1))
            }
            
            //checks if column+1 is valid
            switch col+1{
            //checks if col+1 is valid in 2D array
            case _ where col+1>=widthP4:
                arr.append((row-1,0))
            //if row-1 is valid
            default:
                arr.append((row-1,col+1))
            }
            //adding col since valid
            arr.append((row-1,col))
        }
        
        //checks if column in row is valid
        
        //checks if column-1 is valid
        switch col-1{
        //checks if col-1 is valid in 2D array
        case _ where col-1<0:
            arr.append((row,widthP4-1))
        //if col-1 is valid
        default:
            arr.append((row,col-1))
        }
        
        //checks if column+1 is valid
        switch col+1{
        //checks if col+1 is valid in 2D array
        case _ where col+1>=widthP4:
            arr.append((row,0))
        //if col+1 is valid
        default:
            arr.append((row,col+1))
            
        }
        //adding column since valid
        arr.append((row,col))
        
        //collecting valid values in row+1
        switch row+1{
            
        //checks if row+1 is valid in 2D array
        case _ where row+1>=heightP4:
            //checks if column-1 is valid
            switch col-1{
            //checks if col-1 is valid in 2D array
            case _ where col-1<0:
                arr.append((0,widthP4-1))
            //if col-1 is valid
            default:
                arr.append((0,col-1))
            }
            
            //checks if column+1 is valid
            switch col+1{
            //checks if col+1 is valid in 2D array
            case _ where col+1>=widthP4:
                arr.append((0,0))
            //if col+1 is valid
            default:
                arr.append((0,col+1))
                
            }
            //adding column since valid
            arr.append((0,col))
        //if row-1 is valid
        default:
            //checks if column-1 is valid
            switch col-1{
            //checks if col-1 is valid in 2D array
            case _ where col-1<0:
                arr.append((row+1,widthP4-1))
            //if col-1 is valid
            default:
                arr.append((row+1,col-1))
            }
            
            //checks if column+1 is valid
            switch col+1{
            //checks if col+1 is valid in 2D array
            case _ where col+1>=widthP4:
                arr.append((row+1,0))
            //if row+1 is valid
            default:
                arr.append((row+1,col+1))
                
            }
            //adding column since valid
            arr.append((row+1,col))
            
        }
        return arr
        
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
