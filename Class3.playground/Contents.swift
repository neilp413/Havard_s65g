//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let word="Hello, playground"
str="bob"


let label="the width is "
let width=94
let widthLabel=label+String(width)

let apple=3
let appleSummary="I have \(apple) apples."
let orange=27
let orangeSummary="I have \(orange) oranges."

class shape{
    var name:String
    var sides:Int
    
    init(name: String,sides:Int){
        self.name=name
        self.sides=sides
    }
}

class triangle:shape{
    var base:Int
    var height:Int

    
    init(base:Int,name: String,height:Int){
        self.base=base
        self.height=height
        super.init(name: name, sides: 3)
    }
    
    func calculateArea()-> Double {
        return 0.5 * Double (base)
    }
}

var shoppingList:NSMutableArray=["catfish","water","tulips","blue paint"]
var copyList=shoppingList

shoppingList.addObject(47)
copyList
var occupation=["Malcom":"Captain","Kalyee":"Mechanic"]

occupation["Jayne"]="Public Relations"
occupation["Bob"]="Plumber"

var names=occupation.map{$0.0}.map{$0; "blah"}

names

var r=50...100
var g=r.generate()

g.next()
g.next()

var g1=[11,2,3,4,5,6].generate()

var tuple1=(1,2)

var tuple2=(first:"van", last:"simons",middle:"n")
tuple2.0
tuple2.last
tuple2.middle

for(k,v) in occupation {
    print("\(k),\(v)")
}




func doubler(x:Int)->Int {
    return x+x
}

doubler(5)

func progression(v:Int,f:Int->Int)->Int{
    return f(v)
}




var tf=true
tf=false

var arr:Array<Dictionary<Int,Bool>>=[[1:true]]

var closure={ (x:Int)-> Int in
    return x*2
}

closure(6)
progression(6,f:closure)

progression(6) {(x:Int)-> Int in
  return x*2 }

var optionalN:Int?=3
var implicitOpN:Int!=5

if let n=optionalN{
    let doubleN=doubler(n)
}

doubler(implicitOpN)




