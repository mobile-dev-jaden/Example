//
//  CalendarView.swift
//  Example
//
//  Created by 김태호 on 2022/05/29.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    @State var reservedDates: [String] = []
    let calendarMode: CalendarMode
    
    init(_ reservedDates: [String], mode calendarMode: CalendarMode) {
        self.reservedDates = reservedDates
        self.calendarMode = calendarMode
    }
    
    func makeCoordinator() -> BaseCoordinator {
        switch calendarMode {
        case .basicCalendarMode:  return BaseCoordinator(reservedDates)
        case .backBlockedMode:    return BackBlockedCoordinator(reservedDates)
        case .forwardBlockedMode: return ForwardBlockedCoordinator(reservedDates)
        }
    }
    
    func makeUIView(context: Context) -> some UIView {
        let calendar = FSCalendar()
        // Delegate & Data source
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        // Event Options
        calendar.appearance.eventDefaultColor = UIColor.black
        calendar.appearance.todayColor = UIColor.blue
        
        return calendar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    // class Coordinator: NSObject { }
    class BaseCoordinator: NSObject {
        let reservedDates: [String]
        
        init(_ dates: [String]) {
            self.reservedDates = dates
        }
    }
    
    fileprivate class BackBlockedCoordinator: BaseCoordinator { }
    fileprivate class ForwardBlockedCoordinator: BaseCoordinator { }
}

extension CalendarView {
    enum CalendarMode {
        case basicCalendarMode,
             backBlockedMode,
             forwardBlockedMode
    }
}

// 모든 캘린더에 공통적으로 적용할 사항들
extension CalendarView.BaseCoordinator: FSCalendarDelegate { }

extension CalendarView.BaseCoordinator: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }
        let eventDate = dateFormatter.string(from: date)
        
        return reservedDates.contains(where: { $0 == eventDate }) ? 1 : 0
    }
}

// 오늘 이전의 날짜는 조작할 수 없는 달력
extension CalendarView.BackBlockedCoordinator {
    func minimumDate(for calendar: FSCalendar) -> Date {
        var date: Date {
            let nowUTC = Date()
            let timeZoneOffset = TimeZone.current.secondsFromGMT() / -60
            guard let localDate = Calendar.current.date(byAdding: .minute,
                                                        value: Int(timeZoneOffset),
                                                        to: nowUTC) else {
                return Date()
            }
            
            return localDate
        }
        return date
    }
}

// 오늘 이후의 날짜는 조작할 수 없는 달력
extension CalendarView.ForwardBlockedCoordinator {
    func maximumDate(for calendar: FSCalendar) -> Date {
        var date: Date {
            let nowUTC = Date()
            let timeZoneOffset = TimeZone.current.secondsFromGMT() / -60
            guard let localDate = Calendar.current.date(byAdding: .minute,
                                                        value: Int(timeZoneOffset),
                                                        to: nowUTC) else {
                return Date()
            }
            
            return localDate
        }
        return date
    }
}
