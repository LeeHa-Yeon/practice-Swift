//
//  CalendarHelper.swift
//  CustomCalendar
//
//  Created by 이하연 on 2022/03/21.
//

import UIKit

class CalendarHelper {
    let calendar = Calendar.current
    
    // 이전달
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    // 다음달
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }

    // 연도 출력
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // 달 출력
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    // 해당 월 일수
    func daysInMonth(date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // 해당 월의 1일의 위치 -> date에는 첫번째날짜가 있어야됨 ( 0 ~ 6 )
    func weekDay(date: Date) -> Int
    {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    // components는 해당 월의 첫번째로 인식되고 return은 하루 전날로 측정됨
    // 이해가 안가면 [.year, .month, .day] 넣어보면 된다.
    func firstOfMonth(date: Date) -> Date
    {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    
}

