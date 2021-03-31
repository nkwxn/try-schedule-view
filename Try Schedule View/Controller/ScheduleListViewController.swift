//
//  ScheduleListViewController.swift
//  Try Schedule View
//
//  Created by Nicholas on 24/03/21.
//

import UIKit

class ScheduleListViewController: UITableViewController {
    var schedule = PrototypeSchedule()
    let today = Date()
    
    // TODO: Date Formatter
    let dateFormat = DateFormatter()
    var categorizedSchedule = [[Schedule]]()
    var dateCategories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Date Formatter Style
        dateFormat.dateStyle = .full
        dateFormat.timeStyle = .none
        
        // MARK: - Sort schedule into
        // Sort schedule into categories
        var sortedSchedule = [Schedule]()
        var sortingDate = Date()
        dateCategories.append("Today")
        
        // Loop to sort tables into categories
        for schedule in schedule.prototypeData {
            if schedule.startDateTime > today {
                if schedule.eventDate == dateFormat.string(from: sortingDate) {
                } else {
                    categorizedSchedule.append(sortedSchedule)
                    sortedSchedule = [Schedule]()
                    sortingDate = schedule.startDateTime
                    dateCategories.append(dateFormat.string(from: sortingDate))
                }
                sortedSchedule.append(schedule)
            }
        }
        categorizedSchedule.append(sortedSchedule)
    }

    // MARK: - TableView Delegate Methods (Number of rows and number of sections)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorizedSchedule[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categorizedSchedule.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule: Schedule = categorizedSchedule[indexPath.section][indexPath.row]
        
        let alert = UIAlertController(title: "\(schedule.activity) \(schedule.subject)", message: "This schedule will start at \(schedule.eventDate) @ \(schedule.eventStartTime) - \(schedule.eventEndTime)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
        /*
        performSegue(withIdentifier: "openScheduleDetail", sender: self)
        let schedule = categorizedSchedule[indexPath.section][indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(identifier: "ViewScheduleViewController") as? ViewScheduleViewController {
            vc.schedule = schedule
            self.navigationController?.pushViewController(vc, animated: true)
        }
        */
    }
    
    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell") as! ScheduleCell
        let schedule = categorizedSchedule[indexPath.section][indexPath.row]
        
        cell.txtStartTime.text = "\(schedule.eventStartTime) - \(schedule.eventEndTime)"
        cell.txtActivity.text = schedule.activity
        cell.txtSubject.text = schedule.subject
        cell.txtDuration.text = "\(schedule.durationMinutes) minutes"
        
//        cell.schedule = schedule
        return cell
    }
    
    // MARK: - TableView categories
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < dateCategories.count {
            return dateCategories[section]
        }
        return nil
    }
}

/*
// MARK: - Segue Data Transfer

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    switch segue.destination {
    case is ViewScheduleViewController:
        if let senderCell = sender as? ScheduleCell,
           let yourController = segue.destination as? ViewScheduleViewController {
            yourController.schedule = senderCell.schedule
    }
    default:
        print("Nothing to prepare")
    }
}
*/
