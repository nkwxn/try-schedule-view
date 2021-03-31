//
//  StudyScheduleTableViewController.swift
//  Try Schedule View
//
//  Created by Nicholas on 27/03/21.
//

import UIKit

class StudyScheduleTableViewController: UITableViewController {
    var schedule = PrototypeSchedule()
    var arrSchedule = [Schedule]()
    var sortedSchedule = [Schedule]()
    
    // MARK: - Date Formatter and Today's date
    let dateFormat = DateFormatter()
    let today = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // MARK: - Date Formatter Style
        dateFormat.dateStyle = .full
        dateFormat.timeStyle = .none
        
        /*
        // MARK: - Large and small title (custom small title because large does not help)
        self.navigationItem.title = "Hello, Andy!"
        self.navigationItem.setTitle("Today's Schedule", subtitle: dateFormat.string(from: today))
        */
        
        // MARK: - Today's schedule title
        self.navigationItem.title = "Today's Schedule"
        
        // Create a small title label
        var labelSubtitle = UILabel()
        labelSubtitle.text = dateFormat.string(from: today)
        labelSubtitle.backgroundColor = UIColor.clear
        labelSubtitle.font = UIFont.systemFont(ofSize: 14)
        
        // Add subview to hierarchy
        
        
        // MARK: - Sort the prototype data
        sortedSchedule = schedule.prototypeData.filter({ (sch: Schedule) in
            return dateFormat.string(from: today) == dateFormat.string(from: sch.startDateTime)
        })
        
        sortedSchedule.sort { (lsch, rsch) -> Bool in
            return lsch.startDateTime < rsch.startDateTime
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedSchedule.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sch = sortedSchedule[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todayScheduleCell", for: indexPath) as! TodayScheduleCell

        // Configure the cell text...
        cell.scheduleTitle.text = "\(sch.activity) \(sch.subject)"
        cell.scheduleStartTime.text = sch.eventStartTime
        cell.scheduleEndTime.text = sch.eventEndTime
        
        // Configure the cell background properties
        cell.scheduleBackground.layer.cornerRadius = 24
        cell.scheduleBackground.layer.borderWidth = 1
        cell.scheduleBackground.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cell.scheduleBackground.layer.masksToBounds = true
        
        var image = UIImage()
        
        if sch.startDateTime < today {
            image = UIImage(named: "after")!
        } else {
            image = UIImage(named: "before")!
        }
        
        // MARK: - Dark mode support for cards
        if traitCollection.userInterfaceStyle == .dark {
            print("Dark mode")
            cell.imageBackground.alpha = 0.3
        } else {
            print("Light mode")
        }
        
        cell.imageBackground.image = image
        cell.imageBackground.contentMode = .scaleToFill
        cell.imageBackground.translatesAutoresizingMaskIntoConstraints = false

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extension UINavigationItem untuk custom title and subtitle (perlu edit2 tipis lagi untuk support dark mode jika diperlukan)
extension UINavigationItem {

    func setTitle(_ title: String, subtitle: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        subtitleLabel.textColor = .systemGray2

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .vertical

        self.titleView = stackView
    }
}
