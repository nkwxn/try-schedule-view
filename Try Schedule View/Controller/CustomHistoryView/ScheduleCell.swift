//
//  ScheduleCell.swift
//  Try Schedule View
//
//  Created by Nicholas on 29/03/21.
//

import UIKit

class TodayScheduleCell: UITableViewCell {
    @IBOutlet var scheduleTitle: UILabel!
    @IBOutlet var scheduleStartTime: UILabel!
    @IBOutlet var scheduleEndTime: UILabel!
    
    // For custom background
    @IBOutlet var scheduleBackground: UIView!
    @IBOutlet var imageBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Schedule UITableViewCell class
class ScheduleCell: UITableViewCell {
    @IBOutlet var txtStartTime: UILabel!
    @IBOutlet var txtActivity: UILabel!
    @IBOutlet var txtSubject: UILabel!
    @IBOutlet var txtDuration: UILabel!
    
//    var schedule: Schedule!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ScheduleCell: Reusable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
