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
    
    
    @IBInspectable var livingColor:UIColor = UIColor.whiteColor()
    @IBInspectable var emptyColor:UIColor = UIColor.whiteColor()
    @IBInspectable var bornColor:UIColor = UIColor.whiteColor()
    @IBInspectable var diedColor:UIColor = UIColor.whiteColor()
    @IBInspectable var gridColor:UIColor = UIColor.whiteColor()
    
    @IBInspectable var gridWidth:CGFloat = 2.0
    
    var grid:Array<Array<CellState>>=Array(count: 20, repeatedValue: Array(count: 20, repeatedValue: CellState.Empty))
    
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
    
    
    
    override func drawRect(rect: CGRect) {
        //creating the vertical path
        let verPath = UIBezierPath()
        
        //setting the width of the vertical path
        verPath.lineWidth = gridWidth
        
        for r in 0...rows{
            //moving to the top of graphview
            verPath.moveToPoint(CGPoint(
                x: bounds.width * CGFloat(r) / CGFloat(rows),
                y: 0))

            //adding a point to the bottom of the graphbiew
            verPath.addLineToPoint(CGPoint(
                x: bounds.width * CGFloat(r) / CGFloat(rows),
                y: bounds.height))
        }
        //setting the color of the stroke
        gridColor.setStroke()
        
        //drawing the vertical stroke
        verPath.stroke()
        
        
        //creating the horizontal path
        let horPath = UIBezierPath()
        
        //setting the width of the horizontal path
        horPath.lineWidth = gridWidth
        
        for c in 0...cols{
            //moving to the left of the graphview
            horPath.moveToPoint(CGPoint(
                x: 0,
                y: bounds.height * CGFloat(c) / CGFloat(cols)))
            
            //adding a point to the right of the graphview
            horPath.addLineToPoint(CGPoint(
                x: bounds.width,
                y: bounds.height * CGFloat(c) / CGFloat(cols)))
        }

        //setting the color of the stroke
        gridColor.setStroke()
        
        //drawing the horizontal stroke
        horPath.stroke()

        for r in 0..<rows{
            for c in 0..<cols{
                
                //Creating a rectangle to put the cell in
                let rect = CGRect(
                    x: bounds.width * CGFloat(r) / CGFloat(rows) + CGFloat(gridWidth/2),
                    y: bounds.height * CGFloat(c) / CGFloat(cols) + CGFloat(gridWidth/2),
                    width: bounds.width / CGFloat(rows) - CGFloat(gridWidth),
                    height: bounds.height / CGFloat(cols) - CGFloat(gridWidth))
                
                //Creating the cell
                let path = UIBezierPath(ovalInRect: rect)
                
                //Choosing the correct color of the cell
                switch grid[r][c]{
                case .Living:
                    livingColor.setFill()
                case .Born:
                    bornColor.setFill()
                case .Died:
                    diedColor.setFill()
                case .Empty:
                    emptyColor.setFill()
                }
                
                //Filling the cell
                path.fill()
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
    
    
    var hor: Int = 0
    var ver: Int = 0
    //Getting the neighbors of a certain row and col
    func neighbors(row: Int, col: Int) -> [(row:Int, col:Int)]{

        return [((row+hor-1)%hor,(col+ver-1)%ver),
                ((row+hor-1)%hor, col),
                ((row+hor-1)%hor, (col+1)%ver),
                (row, (col+ver-1)%ver),
                (row, (col+1)%ver),
                ((row+1)%hor, (col+ver-1)%ver),
                ((row+1)%hor, col),
                ((row+1)%hor, (col+1)%ver)]
    }
    
    
    func step(horizontal: Int, vertical: Int, cells: Array<Array<CellState>>) -> Array<Array<CellState>> {
        var countNeighbors = 0
        var arr  = Array<Array<CellState>>(count: cells.count, repeatedValue: [CellState](count: cells[0].count, repeatedValue: .Empty))
        hor = horizontal
        ver = vertical
        for r in 0 ..< cells.count {
            for c in 0 ..< cells[r].count{
                let num = neighbors(r, col:c)
                for item in num{
                    if cells[item.0][item.1] == .Living || cells[item.0][item.1] == .Born{
                        countNeighbors += 1
                    }
                }
                
                switch countNeighbors{
                case 2:
                    switch cells[r][c]{
                    case .Born, .Living:
                        arr[r][c] = .Living
                    case .Died, .Empty:
                        arr[r][c] = .Empty
                    }
                case 3:
                    switch cells[r][c]{
                    case .Died, .Empty:
                        arr[r][c] = .Born
                    case.Living, .Born:
                        arr[r][c] = .Living
                    }
                default:
                    switch cells[r][c]{
                    case .Born, .Living:
                        arr[r][c] = .Died
                    case .Empty, .Died:
                        arr[r][c] = .Empty
                    }
                }
                
                
                countNeighbors = 0
            }
            
        }
        return arr
    }
    
}


