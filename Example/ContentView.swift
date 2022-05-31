//
//  ContentView.swift
//  Example
//
//  Created by 김태호 on 2022/05/29.
//

import SwiftUI

struct ContentView: View {
    
    private var dates = [
        "2022-05-31",
        "2022-06-01",
        "2022-06-02",
        "2022-06-03",
    ]
    
    var body: some View {
        NavigationView {
            HStack {
                NavigationLink("Forward Blocked Mode") {
                    CalendarView(dates, mode: .forwardBlockedMode)
                }
                
                NavigationLink("Plain Mode") {
                    CalendarView(dates, mode: .basicCalendarMode)
                }
                
                NavigationLink("Backward Blocked Mode") {
                    CalendarView(dates, mode: .backBlockedMode)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
