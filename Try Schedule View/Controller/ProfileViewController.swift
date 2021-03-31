//
//  ProfileViewController.swift
//  Try Schedule View
//
//  Created by Nicholas on 28/03/21.
//

import UIKit

struct Constants {
    static let stdCornerRadius: CGFloat = 14.0
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var schedule = PrototypeSchedule()
    
    // MARK: - Array of sorted history
    var historyDate = [String]()
    var historyContent = [[Schedule]]()
    let today = Date()
    var dateFormat = DateFormatter()
    
    // MARK: - View loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Set Tableview Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - Date Formatter Setup
        dateFormat.dateStyle = .full
        dateFormat.timeStyle = .none
        
        // MARK: - Sort the prototype data descending (because history)
        schedule.prototypeData.sort { (lsch, rsch) -> Bool in
            return lsch.startDateTime > rsch.startDateTime
        }
        
        // MARK: - Categorize and group by date
        var sortedSchedule = [Schedule]()
        var sortingDate = Date()
        historyDate.append("Today")
        
        for schedule in schedule.prototypeData {
            if schedule.startDateTime <= today {
                if schedule.eventDate == dateFormat.string(from: sortingDate) {
                } else {
                    historyContent.append(sortedSchedule)
                    sortedSchedule = [Schedule]()
                    sortingDate = schedule.startDateTime
                    historyDate.append(dateFormat.string(from: sortingDate))
                }
                sortedSchedule.append(schedule)
                sortedSchedule.sort { (lsch, rsch) -> Bool in
                    lsch.startDateTime < rsch.startDateTime
                }
            }
        }
        historyContent.append(sortedSchedule)
        
        registerViewsToTableView()
    }
    
    private func registerViewsToTableView() {
        tableView.register(UINib(nibName: "CustomScheduleCell", bundle: nil), forCellReuseIdentifier:ScheduleCell.ReuseID())
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier:CustomHeaderView.ReuseID())
        tableView.register(UINib(nibName: "CustomFooter", bundle: nil), forHeaderFooterViewReuseIdentifier:CustomFooterView.ReuseID())
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Number of rows for each sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyContent[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return historyContent.count
    }
    
    // MARK: - Initialize table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentHistory = historyContent[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.ReuseID()) as! ScheduleCell
        cell.txtStartTime.text = "\(currentHistory.eventStartTime) - \(currentHistory.eventEndTime)"
        cell.txtSubject.text = currentHistory.subject
        cell.txtActivity.text = currentHistory.activity
        cell.txtDuration.text = "\(currentHistory.durationMinutes) minutes"
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: Section View Handling
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.ReuseID()) as? CustomHeaderView  else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.ReuseID()) as! CustomHeaderView
        headerView.dateLabel.text = historyDate[section]
        return headerView
    }
       
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomFooterView.ReuseID()) as? CustomFooterView  else { return nil }
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomFooterView.ReuseID()) as! CustomFooterView
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}
