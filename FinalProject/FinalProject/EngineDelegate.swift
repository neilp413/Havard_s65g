//
//  EngineDelegate.swift
//  FinalProject
//
//  Created by Neil Patel on 7/29/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit

protocol  EngineDelegate: class {
    func engineDidUpdate(withGrid: GridProtocol)
}