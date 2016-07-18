//
//  Engine.swift
//  Assignment4
//
//  Created by Neil Patel on 7/16/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import Foundation

protocol EngineDelegateProtocol {
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol EngineProtocol{
    var delegate: EngineDelegateProtocol? { get set }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    var refreshTimer: NSTimer? { get set }
    var rows: Int { get set }
    var cols: Int { get set }
    init(rows: Int, cols: Int)
    func step() -> GridProtocol
}

//use the extension
extension EngineProtocol{
    var refreshRate: Double{
        return 0.0
    }
}
protocol GridProtocol: class {
    init(rows: Int, cols: Int)
    var rows: Int {get}
    var cols: Int {get}
    func neighbors(cords: (Int,Int)) -> [(Int, Int)]
    subscript(row: Int, column: Int) -> CellState? { get set }
}

class Grid: GridProtocol {
    var rows: Int
    var cols: Int
    var grid:Array<Array<CellState>>
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: CellState.Empty))
    }
    
    func neighbors(cords: (Int,Int)) -> [(Int, Int)] {
        let row = cords.0
        let column = cords.1
        
        return [((row+rows-1)%rows,(column+cols-1)%cols),
                ((row+rows-1)%rows, column),
                ((row+rows-1)%rows,(column+1)%cols),
                (row, (column+cols-1)%cols),
                (row, (column+1)%cols),
                ((row+1)%rows, (column+cols-1)%cols),
                ((row+1)%rows, column),
                ((row+1)%rows, (column+1)%cols)]
    }
    
    subscript(row: Int, column: Int) -> CellState?{
        get{
            if row >= rows || column >= cols{ return nil }
            return grid[row][column]
        }
        set{
            if newValue == nil { return }
            if row < 0 || row >= rows || column < 0 || column >= cols { return }
            grid[row][column] = newValue!
        }
    }
}

class StandardEngine: EngineProtocol {
    
    private static var _sharedInstance = StandardEngine(rows:10, cols: 10)
    static var sharedInstance: StandardEngine {
        get {
            return _sharedInstance
        }
    }
    
    var delegate: EngineDelegateProtocol?
    var grid: GridProtocol
    
    var rows: Int {
        didSet {
            
            if let delegate = delegate {
                delegate.engineDidUpdate(grid)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("setEngineStaticsNotification", object: self, userInfo: ["value" : grid])
        }
    }
    var cols: Int {
        didSet {
            StandardEngine.sharedInstance.cols = cols
            if let delegate = delegate {
                delegate.engineDidUpdate(grid)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("setEngineStaticsNotification", object: nil, userInfo: ["value" : grid])
        }
    }
    

    var refreshTimer:NSTimer?
    
    var refreshRate: Double = 0 {
        didSet {
            if refreshRate != 0 {
                if let timer = refreshTimer { timer.invalidate() }
                let sel = #selector(StandardEngine.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                                      target: self,
                                                                      selector: sel,
                                                                      userInfo: nil,
                                                                      repeats: true)
            }
            else if let timer = refreshTimer {
                timer.invalidate()
                self.refreshTimer = nil
            }
        }
    }
    
    
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Grid(rows: rows, cols: cols)
    }
    
    func step() -> GridProtocol {
        var livingNeighbors = 0
        
        let cell: GridProtocol = Grid(rows: rows, cols: cols)
        
        for r in 0 ..< rows {
            for c in 0 ..< cols{
                let arr = grid.neighbors((r,c))
                for items in arr{
                    if grid[items.0, items.1] == .Living || grid[items.0, items.1] == .Born{
                        livingNeighbors += 1
                    }
                }
                
                switch livingNeighbors{
                case 2:
                    switch grid[r,c]!{
                    case .Born, .Living:
                        cell[r,c] = .Living
                    case .Died, .Empty:
                        cell[r,c] = .Empty
                    }
                case 3:
                    switch grid[r,c]!{
                    case .Died, .Empty:
                        cell[r,c] = .Born
                    case.Living, .Born:
                        cell[r,c] = .Living
                    }
                default:
                    switch grid[r,c]!{
                    case .Born, .Living:
                        cell[r,c] = .Died
                    case .Empty, .Died:
                        cell[r,c] = .Empty
                    }
                }
                livingNeighbors = 0
            }
        }
        
        //call the delegate method to update
        if let delegate = delegate {
            delegate.engineDidUpdate(grid)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("setEngineStaticsNotification", object: nil, userInfo: ["value" : grid])
        
        return cell
        
    }
    
    @objc func timerDidFire(timer:NSTimer) {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
    }
}






