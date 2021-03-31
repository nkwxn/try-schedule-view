//
//  PrototypeScheduleData.swift
//  Try Schedule View
//
//  Created by Nicholas on 28/03/21.
//

import Foundation

class PrototypeSchedule {
    
    // MARK: - Prototype Data. Can be replaced with CoreData Stack
    var prototypeData = [
        Schedule(
            activity: "Homework", subject: "English", startDateTime: Date.yesterday, durationMinutes: 90
        ),
        Schedule(
            activity: "Exam", subject: "Physics", startDateTime: Date(), durationMinutes: 100
        ),
        Schedule(
            activity: "Review", subject: "Math", startDateTime: Date.twoHoursMore, durationMinutes: 120
        ),
        Schedule(
            activity: "Homework", subject: "Physics", startDateTime: Date.tomorrow, durationMinutes: 100
        ),
        Schedule(
            activity: "Homework", subject: "Math", startDateTime: Date.tomorrow, durationMinutes: 60
        ),
        Schedule(
            activity: "Review", subject: "Biology", startDateTime: Date.twoDaysTwoHoursMore, durationMinutes: 120
        ),
        Schedule(
            activity: "Exam", subject: "Biology", startDateTime: Date.todayPastOneHour, durationMinutes: 100
        ),
        Schedule(
            activity: "Learn Something New", subject: "Chemistry", startDateTime: Date.twoHoursMore, durationMinutes: 240
        )
    ]
    
    init() {
        prototypeData.sort { (lsch, rsch) -> Bool in
            return lsch.startDateTime < rsch.startDateTime
        }
    }
}

// MARK: - Date Extension
extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow: Date { return Date().dayAfter }
    static var todayPastOneHour: Date {
        var dateComponents = DateComponents()
        dateComponents.hour = -1
        return Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
    }
    static var twoHoursMore: Date {
        var dateComponents = DateComponents()
        dateComponents.hour = 2
        return Calendar.current.date(byAdding: dateComponents, to: Date())!
    }
    static var twoDaysTwoHoursMore: Date {
        var dateComponents = DateComponents()
        dateComponents.hour = 2
        dateComponents.day = 2
        return Calendar.current.date(byAdding: dateComponents, to: Date())!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
