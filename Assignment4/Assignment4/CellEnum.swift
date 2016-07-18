//
//  Cell Enum.swift
//  Assignment3
//
//  Created by Neil Patel on 7/9/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import Foundation

enum CellState:String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    //Gets the raw value of the enum
    func description() -> String {
        switch self {
        case Living:
            return Living.rawValue
        case Empty:
            return Empty.rawValue
        case Born:
            return Born.rawValue
        case Died:
            return Died.rawValue
        }
    }
    
    func allValues() -> [CellState] {
        return [Living,Empty,Born,Died]
    }
    
    static func toggle(value:CellState) -> CellState {
        switch value {
        case Empty,Died:
            return .Living
        case Living, Born:
            return .Empty
        }
    }
}