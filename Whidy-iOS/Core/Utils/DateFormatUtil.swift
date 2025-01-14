//
//  DateFormat.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 9/16/24.
//

import Foundation

enum DateStringFormat: String {
    case yyyyMMdd = "yyyyMMdd"
    case yyyyMMddHHmmss = "yyyyMMddHHmmss"
    case yyyyMMddWithDot = "yyyy.MM.dd"
    case yyyyMMddHHmmWithDot = "yyyy.MM.dd HH:mm"
    case yyyyMM = "yyyyMM"
    case yyyyMMWithDot = "yyyy.MM"
    case yyyy = "yyyy"
    case yyMMdd = "yyMMdd"
    case mmdd = "MMdd"
    case mmddWithDot = "MM.dd"
    case mm = "MM"
    case dd = "dd"
    case mWithoutZero = "M"
    case normal = "yyyy-MM-dd hh:mm:ss"
    case normalHH = "yyyy-MM-dd HH:mm:ss"
    case normalDate = "yyyy-MM-dd"
    
    var localizedString: String {
        return rawValue
    }
    
}

class DateFormatUtil {
    //issue: invalid TimeZone.current on ios 10
    
    enum Constants {
        static let yearInMonthMax: Int = 12
        static let limitYear: Int = 10
        static let monthInDayMax: Int = 31
        static let monthInit: Int = 1
        static let weekExceptionDay: Int = 8
    }
    static var currentTimeZone: TimeZone {
        return TimeZone.current
    }
    
    static func getEndYears( selectYear: Int ) -> [String] {
        
        var yearsArray: [String] = Array()
        
        let maxLimitYear = selectYear + Constants.limitYear
        
        for index in selectYear...maxLimitYear {
            yearsArray.append(String(index))
        }
        
        return yearsArray
    }
    
    static func getEndYearWeekMonth( startYear: Int, selectYear: Int, selectMonth: Int ) -> [String] {
        
        var monthArray: [String] = Array()
        var month = selectMonth
        
        let maxLimitMonth = Constants.yearInMonthMax
        
        if startYear != selectYear {
            month = Constants.monthInit
        }
        
        for index in month...maxLimitMonth {
            monthArray.append(index.string)
        }
        
        return monthArray
    }
    static func getEndYearMonth( startYear: Int, selectYear: Int, selectMonth: Int ) -> [String] {
        
        var monthArray: [String] = Array()
        
        var month = selectMonth
        if month != Constants.yearInMonthMax {
            month += 1
        }
    
        let maxLimitMonth = Constants.yearInMonthMax
        
        if startYear != selectYear {
            month = Constants.monthInit
        }
        
        for index in month...maxLimitMonth {
            monthArray.append(index.string)
        }
        
        return monthArray
    }
    
    static func getNowYear() -> Int {
        return Calendar.current.component(.year, from: Date())
    }
    static func getNowMonth() -> Int {
        return Calendar.current.component(.month, from: Date())
    }
    
    static func getNowTenYears() -> [String] {
        var yearsTenArray: [String] = Array()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        
        let maxLimitYear = Constants.limitYear
        
        for index in 0...maxLimitYear {
            yearsTenArray.append(String(year + index))
        }
        return yearsTenArray
    }
    
    static func getYearMonth( selectYear: Int ) -> [String] {
        
        var monthArray: [String] = Array()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        var month = calendar.component(.month, from: Date())
        
        let maxLimitMonth = Constants.yearInMonthMax
        
        if year != selectYear {
            month = Constants.monthInit
         }
        
        for index in month...maxLimitMonth {
            monthArray.append(index.string)
        }
        
        return monthArray
    }
    
    static func getYearMonthDay( selectYear: Int, selectMonth: Int ) -> [String] {
        
        var dayArray: [String] = Array()
        let calendar = Calendar.current
        var day = 1
        
        if calendar.component(.year, from: Date()) == selectYear && calendar.component(.month, from: Date()) == selectMonth {
            day = calendar.component(.day, from: Date())
        }
        let maxLimitDay = Constants.monthInDayMax
        
        for index in day...maxLimitDay {
            dayArray.append(String(index))
        }
        
        return dayArray
    }
    
    static func getYearMonthDay() -> [String] {
        
        var dayArray: [String] = Array()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: Date())
        
        let maxLimitDay = Constants.monthInDayMax
        
        for index in day...maxLimitDay {
            dayArray.append(String(index))
        }
        
        return dayArray
    }
        
    static var calendarMaximumYear: Int {
        let maxDisplayYear = 82
        let calendar = Calendar(identifier: .gregorian)
        let currentYear = calendar.component(.year, from: Date())
        return currentYear + maxDisplayYear
    }
}

