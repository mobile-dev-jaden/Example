//
//  CalendarView.swift
//  Example
//
//  Created by 김태호 on 2022/05/29.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> some UIView {
        let calendar = FSCalendar()
        // Delegate & Data source
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator

        // Event Options
        calendar.appearance.eventDefaultColor = UIColor.blue
        calendar.appearance.todayColor = UIColor.green
        
        return calendar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject { }
}

extension CalendarView.Coordinator: FSCalendarDelegate {
    
}

extension CalendarView.Coordinator: FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
