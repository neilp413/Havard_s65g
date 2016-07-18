//
//  Model.swift
//  Assignment4
//
//  Created by Neil Patel on 7/14/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import Foundation

protocol GridProtocol {
    var row:Int {get set}
    var col:Int {get set}
    init(row: Int, col:Int)
    func neighbors(cords: (Int,Int))->Array<(Int,Int)>
    subscript(row: Int, col: Int) -> CellState?{ get set }
    
}

protocol EngineDelegate {
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol EngineProtocol {
    var delegate: EngineDelegate? {get set}
    var grid: GridProtocol{get}
    //default value of 0 set in Standard Engine
    var refreshRate:Double {get set}
    var refreshTimer:NSTimer? {get set}
    var row: Int {get set}
    var col: Int {get set}
    init(row: Int,col: Int)
    func step()->GridProtocol
}

class Grid: GridProtocol {
    
    //The 2D array holding all the cellstates
    var cells:Array<Array<CellState>>
    
    var row: Int
    var col: Int
    
    required init(row: Int, col: Int) {
        self.row=row
        self.col=col
        cells=Array(count: row, repeatedValue: Array(count: row, repeatedValue: .Empty))
    }
    
    func neighbors(cords: (Int, Int)) -> Array<(Int, Int)> {
        let r = cords.0
        let c = cords.1
        
        return [((r+col-1)%col,(c+row-1)%row),
                ((r+col-1)%col, c),
                ((r+col-1)%col, (c+1)%row),
                (r, (c+row-1)%row),
                (r, (c+1)%row),
                ((r+1)%col, (c+row-1)%row),
                ((r+1)%col, c),
                ((r+1)%col, (c+1)%row)]
        
    }
    
    subscript(row: Int, col: Int) ->CellState?{
        get{
            if (row > -1 && row < self.row) && (col > -1 && col < self.col){
                return cells[row][col]
            }
            return nil
        }
        set (newValue){
            if (row > -1 && row < self.row) && (col > -1 && col < self.col) &&
                newValue != nil{
                cells[col][row]=newValue!
            }
        }
    }
}

class StandardEngine: EngineProtocol {
    var delegate: EngineDelegate?
    var grid: GridProtocol{
        didSet{
            if let delegate = delegate {
                delegate.engineDidUpdate(grid)
            }
        }
    }
    
    var row: Int{
        didSet{
            if let delegate = delegate {
                delegate.engineDidUpdate(grid)
            }
        }
    }
    var col: Int{
        didSet{
            if let delegate = delegate {
                delegate.engineDidUpdate(grid)
            }
        }
    }
    
    required init(row: Int, col: Int) {
        self.row=row
        self.col=col
        grid=Grid(row: row, col: col)
    }
    
    //Creating the singleton in a lazy manner with a 10 by 10 grid default
    private static var singleton = StandardEngine(row: 10,col: 10)
    static var sharedInstance: StandardEngine{
        get{
            return singleton
        }
    }
    
    //FIX
    
    var refreshTimer: NSTimer?
    //We never talked about implenting default values for protocols in class
    //and I was told this method was ok was ok in the discussion
    var refreshRate: Double=0
        {
        didSet{
            if refreshRate != 0{
                if let timer = refreshTimer{
                    timer.invalidate()
                }
                let sel = #selector(StandardEngine.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                                      target: self,
                                                                      selector: sel,
                                                                      userInfo: ["name": "fred"],
                                                                      repeats: true)
                
            }
        }
    }
    
    
    //IMPLEMENT
    func step() -> GridProtocol{
        return grid
    }
    
    @objc func timerDidFire(timer:NSTimer){
        
    }
    
}