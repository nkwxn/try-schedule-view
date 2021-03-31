//
//  Schedule.swift
//  Try Schedule View
//
//  Created by Nicholas on 28/03/21.
//

import Foundation

// MARK: - Schedule Struct
// TODO: Struct ini dapat digunakan berulang kali pada halaman schedule, today's schedule dan history
// TODO: Pikirkan bagaimana struktur database untuk CoreData pada aplikasi Belmud.
struct Schedule {
    var activity: String
    var subject: String
    var startDateTime: Date
    var durationMinutes: Int
    
    var eventDate: String
    var eventStartTime: String
    var eventEndTime: String
    
    init(activity: String, subject: String, startDateTime: Date, durationMinutes: Int) {
        self.activity = activity
        self.subject = subject
        self.startDateTime = startDateTime
        self.durationMinutes = durationMinutes
        
        // MARK: - Date and Time formatter
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .full
        dateFormat.timeStyle = .none
        
        let timeFormat = DateFormatter()
        timeFormat.dateStyle = .none
        timeFormat.timeStyle = .short
        
        // MARK: - Make the end time based on minutes
        var dateComponent = DateComponents()
        dateComponent.minute = durationMinutes
        let endTime = Calendar.current.date(byAdding: dateComponent, to: startDateTime)
        
        // MARK: - Date, Time start and End in a form of String
        eventDate = dateFormat.string(from: startDateTime)
        eventStartTime = timeFormat.string(from: startDateTime)
        eventEndTime = timeFormat.string(from: endTime!)
    }
}
