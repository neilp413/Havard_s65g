//
//  GridView.swift
//  Assignment3
//
//  Created by Neil Patel on 7/9/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

@IBDesignable

class GridView: UIView {
    
    @IBInspectable var rows:Int = 20{
        didSet{
            grid=Array(count:rows, repeatedValue:Array(count:cols, repeatedValue:CellState.Empty))
        }
    }
    @IBInspectable var cols:Int = 20{
        didSet{
            grid=Array(count:rows, repeatedValue:Array(count:cols, repeatedValue:CellState.Empty))
        }
    }
    @IBInspectable var livingColor:UIColor = UIColor.whiteColor()
    @IBInspectable var emptyColor:UIColor = UIColor.whiteColor()
    @IBInspectable var bornColor:UIColor = UIColor.whiteColor()
    @IBInspectable var diedColor:UIColor = UIColor.whiteColor()
    @IBInspectable var gridColor:UIColor = UIColor.whiteColor()
    
    @IBInspectable var gridWidth:CGFloat = 2.0
    
    var grid:Array<Array<CellState>>=Array(count: 20, repeatedValue: Array(count: 20, repeatedValue: CellState.Empty))
    
    override func drawRect(rect: CGRect) {
        
        //creating the grid
        
        //amount of lines that need to be drawn
        let lineAmountHorizontal = rows+1
        let lineAmountVertical = cols+1
        
        //creating the path
        let gridPath = UIBezierPath()
        
        gridPath.lineWidth=gridWidth
        
        //vertical lines
        
        //Calculating the space between the lines
        var spaceBetween:CGFloat = (bounds.width - gridWidth*CGFloat(lineAmountVertical))/CGFloat(cols)
        
        //the starting x position
        var startPoint:CGFloat = gridWidth/2
        
        for _ in 0..<lineAmountVertical{
            //setting up at the top of the line
            gridPath.moveToPoint(CGPoint(
                x:startPoint,
                y:0))
            
            //adding a point at the bottom of the line
            gridPath.addLineToPoint(CGPoint(
                x:startPoint,
                y:bounds.height))
            
            //changing the x position
            startPoint+=spaceBetween+gridWidth
            
            //setting the color of the stroke
            gridColor.setStroke()
            
            //drawing the stroke
            gridPath.stroke()
        }
        
        //horizontal lines
        
        //Calculating the space between the lines
        spaceBetween = (bounds.height-gridWidth*CGFloat(lineAmountHorizontal))/CGFloat(rows)
        
        //the starting y position
        startPoint = gridWidth/2
        
        for _ in 0..<lineAmountHorizontal{
            //setting up at the left of the line
            gridPath.moveToPoint(CGPoint(
                x:0,
                y:startPoint))
            
            //adding a point at the right of the line
            gridPath.addLineToPoint(CGPoint(
                x:bounds.width,
                y:startPoint))
            
            //changing the y position
            startPoint+=spaceBetween+gridWidth
            
            //setting the color of the stroke
            gridColor.setStroke()
            
            //drawing the stroke
            gridPath.stroke()
        }
        
        //Creating the cells in the grid
        for r in 0..<rows{
            for c in 0..<cols{
                //Creating the rectangle for the cell to be placed in
                let rect = CGRect(
                    x: bounds.width * CGFloat(r) / CGFloat(rows) + gridWidth,
                    y: bounds.height * CGFloat(c) / CGFloat(cols) + gridWidth,
                    width: bounds.width / CGFloat(rows) - 2 * gridWidth,
                    height: bounds.height / CGFloat(cols) - 2 * gridWidth)
                
                //Creating the cell in the rectangle
                let cell = UIBezierPath(ovalInRect: rect)
                
                //Getting the correct color depending on the cell state
                switch grid[r][c]{
                case .Living: livingColor.setFill()
                case .Born: bornColor.setFill()
                case .Died: diedColor.setFill()
                case .Empty: emptyColor.setFill()
                }
                
                //filling the color of the cell
                cell.fill()
            }
        }
        
        
    }
    
    //Changing the the cell state if touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let width = Double(bounds.width) / Double(rows)
            let height = Double(bounds.height) / Double(cols)
            
            let point = touch.locationInView(self)
            let x = Int(floor(Double(point.x) / width))
            let y = Int(floor(Double(point.y) / height))
            
            //checking if it's in the grid
            if (x <= rows-1 && x >= 0) && (y<=cols-1 && y>=0){
                grid[x][y] = CellState.toggle(grid[x][y])
            }
            //creating the rectangle to be updated
            let rect = CGRect(x: CGFloat(Double(x) * width),
                              y: CGFloat(Double(y) * height),
                              width: CGFloat(width),
                              height: CGFloat(height))
            //Updating the rectangle
            self.setNeedsDisplayInRect(rect)
        }
    }
}



