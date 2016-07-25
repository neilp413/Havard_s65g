
import UIKit

func isLeap(year:Int) -> Bool{
    return (year%4 == 0) != ((year%100 == 0) != (year%400 == 0))
}

var monthArr = [31,28,31,30,31,30,31,31,30,31,30,31]

func julianDate(year:Int, month:Int, day:Int) -> Int{
    let daysYear = (1900..<year).reduce(0){return isLeap($1) ? $0 + 366: $0 + 365}
    let daysMonth = (0..<month-1).reduce(0){return isLeap(year) ? $0 + ($1 == 1 ? 29:monthArr[$1]): $0 + monthArr[$1]}
    return daysYear + daysMonth + day
}

julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)

isLeap(1960)
isLeap(1900)
isLeap(2000)
