//
//  ScheduleViewController.swift
//  Try Schedule View
//
//  Created by Nicholas on 24/03/21.
//

import UIKit

class ScheduleViewController: UIViewController {
    @IBOutlet var scheduleTableView: UITableView!
    @IBOutlet var scheduleDatePicker: UIDatePicker!
    
    var schedule = PrototypeSchedule()
    var filteredSchedule = [Schedule]()
    var selectedDate = Date()
    
    // TODO: Date Formatter
    let dateFormat = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        dateFormat.dateStyle = .full
        dateFormat.timeStyle = .none
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleDatePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        // MARK: - Fiter the Schedule
        filteredSchedule = schedule.prototypeData.filter({ (schedule: Schedule) -> Bool in
            return dateFormat.string(from: selectedDate) == dateFormat.string(from: schedule.startDateTime)
        })
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        let date: Date = picker.date
        
        selectedDate = date
        print(dateFormat.string(from: selectedDate))
        
        filteredSchedule = schedule.prototypeData.filter({ (schedule: Schedule) -> Bool in
            return dateFormat.string(from: selectedDate) == dateFormat.string(from: schedule.startDateTime)
        })
        
        // TODO: Reload schedule when date selected.
        scheduleTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    // Define number of rows on TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSchedule.count
    }
    
    // Define the contents on each rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell") as! ScheduleCell
        let schedule = filteredSchedule[indexPath.row]
        
        cell.txtStartTime.text = "\(schedule.eventStartTime) - \(schedule.eventEndTime)"
        cell.txtActivity.text = schedule.activity
        cell.txtSubject.text = schedule.subject
        cell.txtDuration.text = "\(schedule.durationMinutes) minutes"
        
        // Set background according to time
//        cell.schedule = schedule
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateFormat.string(from: selectedDate)
    }
}



