//
//  ViewController.swift
//  TestAssig2
//
//  Created by Neil Patel on 6/28/16.
//  Copyright © 2016 Neil Patel. All rights reserved.
//

import UIKit
import Foundation

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class Problem2ViewController: UIViewController {
    
    @IBAction func Problem2Button(sender: AnyObject) {
    }
   
    @IBOutlet weak var Problem2TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Problem 2"
    }
}

class Problem3ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Problem 3"
    }
}

class Problem4ViewControler: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Problem 4"
    }
}




class TwoDimensional{
    
    
        var bob:Array<Int>

    
    enum Colors{
        case Red, Orange, Yellow, Green, Blue
    }
    
    
    
    
    let height: Int
    let width: Int
    var  array:Array<Array<Bool>>
    
    
    init(height: Int, width: Int){
    self.height=height
    self.width=width
    
    
    self.array = Array(count: height, repeatedValue: Array(count: width, repeatedValue:false))
    
    
    
    for h in 0..<height{
        for w in 0..<width{
            array[h][w] = false
        }
     }
    
    
    //vs
    
    for arryBool in array{
        for boolc in arryBool{
         print(boolc)
    }
     }
}

    
    /**
     -paramater value:
     
     -returns:
 */
    private func somethingElse(value: Int=0){
        print(value)
    }
    
}


var arr=[[false,true,false,true],[false]]




enum NeighborStatus{

    case alive
    case dead
    case starved
    case overpopulated
    case reporduced
    
    var isAlive: Bool{
        switch self {
        case .alive:
            fallthrough
        case .starved:
            return true
            
        case .overpopulated,.dead:
            return false
        default:
            return true;
        }
    }
    
}
    /*
 xxxoo
 xtxoo
 xxxoo
 ooooo
 
 
 tx0x
 xxoo
 oooo
 xxox
 */
    
    
    typealias cellIndex=(length: Int, width: Int)
    typealias something=Array<Array<Int>>
    

    





















