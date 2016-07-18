//
//  Grid.swift
//  Assignment4
//
//  Created by Neil Patel on 7/16/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import Foundation

enum CellState: String{
    case Living = "living"
    case Empty = "empty"
    case Born = "born"
    case Died = "died"
    
    static func description(value: CellState) -> String{
        switch value{
        case .Living: return "living"
        case .Empty: return "empty"
        case .Born: return "born"
        case .Died: return "died"
        }
    }
    
    static func allValues() -> [CellState]{
        return([.Living, .Born, .Died, .Empty])
    }
    
    static func toggle(value: CellState) -> CellState{
        switch value {
        case .Empty, .Died:
            return(.Living)
        case .Living, .Born:
            return(.Empty)
        }
    }
}

