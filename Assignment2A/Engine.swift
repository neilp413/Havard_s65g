//
//  Engine.swift
//  Assignment2
//
//  Created by Neil Patel on 7/1/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import Foundation


func step(cells:Array<Array<Bool>>)->Array<Array<Bool>>
{
    var arr=cells
    
    for row in 0..<arr.count
    {
        for col in 0..<arr[0].count
        {
            var count=0
            
            //checks if row-1 has active cell
            switch row-1{
                
            //checks if row-1 is valid in 2D array
            case _ where row-1<0:
                //checks if column-1 has active cell
                switch col-1{
                //checks if col-1 is valid in 2D array
                case _ where col-1<0:
                    if arr[arr.count-1][arr[0].count-1]{
                        count+=1
                    }
                //if col-1 is valid
                default:
                    if arr[arr.count-1][col-1]{
                        count+=1
                    }
                }
                
                //checks if column+1 has active cell
                switch col+1{
                //checks if col+1 is valid in 2D array
                case _ where col+1>=arr[0].count:
                    if arr[arr.count-1][0]{
                        count+=1
                    }
                //if col+1 is valid
                default:
                    if arr[arr.count-1][col+1]{
                        count+=1
                    }
                    
                }
                //checks for column has avtive cell
                if arr[arr.count-1][col]{
                    count+=1
                }
            //if row-1 is valid
            default:
                //checks if column-1 has active cell
                switch col-1{
                //checks if col-1 is valid in 2D array
                case _ where col-1<0:
                    if arr[row-1][arr[0].count-1]{
                        count+=1
                    }
                //if col-1 is valid
                default:
                    if arr[row-1][col-1]{
                        count+=1
                    }
                }
                
                //checks if column+1 has active cell
                switch col+1{
                //checks if col+1 is valid in 2D array
                case _ where col+1>=arr[0].count:
                    if arr[row-1][0]{
                        count+=1
                    }
                //if row-1 is valid
                default:
                    if arr[row-1][col+1]{
                        count+=1
                    }
                    
                }
                //checks for column has avtive cell
                if arr[row-1][col]{
                    count+=1
                }
            }
            
            //checks if row has active cell
            
            //checks if column-1 has active cell
            switch col-1{
            //checks if col-1 is valid in 2D array
            case _ where col-1<0:
                if arr[row][arr[0].count-1]{
                    count+=1
                }
            //if col-1 is valid
            default:
                if arr[row][col-1]{
                    count+=1
                }
            }
            
            //checks if column+1 has active cell
            switch col+1{
            //checks if col+1 is valid in 2D array
            case _ where col+1>=arr[0].count:
                if arr[row][0]{
                    count+=1
                }
            //if col+1 is valid
            default:
                if arr[row][col+1]{
                    count+=1
                }
                
            }
            //checks for column has avtive cell
            if arr[row][col]{
                count+=1
            }
            
            //checks if row+1 has active cell
            switch row+1{
                
            //checks if row+1 is valid in 2D array
            case _ where row+1>=arr.count:
                //checks if column-1 has active cell
                switch col-1{
                //checks if col-1 is valid in 2D array
                case _ where col-1<0:
                    if arr[0][arr[0].count-1]{
                        count+=1
                    }
                //if col-1 is valid
                default:
                    if arr[0][col-1]{
                        count+=1
                    }
                }
                
                //checks if column+1 has active cell
                switch col+1{
                //checks if col+1 is valid in 2D array
                case _ where col+1>=arr[0].count:
                    if arr[0][0]{
                        count+=1
                    }
                //if col+1 is valid
                default:
                    if arr[0][col+1]{
                        count+=1
                    }
                    
                }
                //checks for column has avtive cell
                if arr[0][col]{
                    count+=1
                }
            //if row-1 is valid
            default:
                //checks if column-1 has active cell
                switch col-1{
                //checks if col-1 is valid in 2D array
                case _ where col-1<0:
                    if arr[row+1][arr[0].count-1]{
                        count+=1
                    }
                //if col-1 is valid
                default:
                    if arr[row+1][col-1]{
                        count+=1
                    }
                }
                
                //checks if column+1 has active cell
                switch col+1{
                //checks if col+1 is valid in 2D array
                case _ where col+1>=arr[0].count:
                    if arr[row+1][0]{
                        count+=1
                    }
                //if row+1 is valid
                default:
                    if arr[row+1][col+1]{
                        count+=1
                    }
                    
                }
                //checks for column has avtive cell
                if arr[row+1][col]{
                    count+=1
                }
            }
            
            //Checking the rules of the cells
            
            //Any live cell with fewer than two live neighbors dies or stays, as if caused by under-population.
            if count<2
            {
                arr[row][col]=false
            }
            //Any live cell with two or three live neighbors lives on to the next generation.
            if arr[row][col] && (count==2||count==3)
            {
                arr[row][col]=true
            }
            //Any live cell with more than three live neighbors dies, as if by overcrowding.
            if arr[row][col] && count>3
            {
                arr[row][col]=false
            }
            //Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
            if !arr[row][col] && count==3
            {
                arr[row][col]=true
            }

        }
    }
    return arr
}