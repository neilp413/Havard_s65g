//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var cells:Array<Array<Bool>>=Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
var width=10
var height=10
var count=0

var r=0
var c=0

cells[1][1]=true

//checks if row-1 has active cell
switch r-1{

//checks if r-1 is valid in 2D array
case _ where r-1<0:
    //checks if column-1 has active cell
    switch c-1{
    //checks if c-1 is valid in 2D array
    case _ where c-1<0:
        if cells[width-1][height-1]{
            count+=1
        }
    //if c-1 is valid
    default:
        if cells[width-1][c-1]{
            count+=1
        }
    }
    
    //checks if column+1 has active cell
    switch c+1{
    //checks if c+1 is valid in 2D array
    case _ where c+1>=height:
        if cells[width-1][0]{
                    count+=1
                }
    //if c+1 is valid
    default:
        if cells[width-1][c+1]{
            count+=1
        }
        
    }
    //checks for column has avtive cell
    if cells[width-1][c]{
        count+=1
    }
//if r-1 is valid
default:
    //checks if column-1 has active cell
    switch c-1{
    //checks if c-1 is valid in 2D array
    case _ where c-1<0:
        if cells[r-1][height-1]{
            count+=1
        }
    //if c-1 is valid
    default:
        if cells[r-1][c-1]{
            count+=1
        }
    }
    
    //checks if column+1 has active cell
    switch c+1{
    //checks if c+1 is valid in 2D array
    case _ where c+1>height:
        if cells[r-1][0]{
            count+=1
        }
    //if r-1 is valid
    default:
        if cells[r-1][c+1]{
            count+=1
        }
        
    }
    //checks for column has avtive cell
    if cells[r-1][c]{
        count+=1
    }
}

//checks if row has active cell

//checks if column-1 has active cell
switch c-1{
//checks if c-1 is valid in 2D array
case _ where c-1<0:
    if cells[r][height-1]{
        count+=1
    }
//if c-1 is valid
default:
    if cells[r][c-1]{
        count+=1
    }
}

//checks if column+1 has active cell
switch c+1{
//checks if c+1 is valid in 2D array
case _ where c+1>height:
    if cells[r][0]{
        count+=1
    }
//if c+1 is valid
default:
    if cells[r][c+1]{
        count+=1
    }
    
}
//checks for column has avtive cell
if cells[r][c]{
    count+=1
}

//checks if row+1 has active cell
switch r+1{
    
//checks if r+1 is valid in 2D array
case _ where r+1>width:
    //checks if column-1 has active cell
    switch c-1{
    //checks if c-1 is valid in 2D array
    case _ where c-1<0:
        if cells[0][height-1]{
            count+=1
        }
    //if c-1 is valid
    default:
        if cells[0][c-1]{
            count+=1
        }
    }
    
    //checks if column+1 has active cell
    switch c+1{
    //checks if c+1 is valid in 2D array
    case _ where c+1>height:
        if cells[0][0]{
            count+=1
        }
    //if c+1 is valid
    default:
        if cells[0][c+1]{
            count+=1
        }
        
    }
    //checks for column has avtive cell
    if cells[0][c]{
        count+=1
    }
//if r-1 is valid
default:
    //checks if column-1 has active cell
    switch c-1{
    //checks if c-1 is valid in 2D array
    case _ where c-1<0:
        if cells[r+1][height-1]{
            count+=1
        }
    //if c-1 is valid
    default:
        if cells[r+1][c-1]{
            count+=1
        }
    }
    
    //checks if column+1 has active cell
    switch c+1{
    //checks if c+1 is valid in 2D array
    case _ where c+1>height:
        if cells[r+1][0]{
            count+=1
        }
    //if r+1 is valid
    default:
        if cells[r+1][c+1]{
            count+=1
        }
        
    }
    //checks for column has avtive cell
    if cells[r+1][c]{
        count+=1
    }
}



func neighbors(cords: (r:Int,c:Int))   {
    var arr=[(Int,Int)]()
    
}




