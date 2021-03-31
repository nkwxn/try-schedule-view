//
//  CustomHeaderView.swift
//  Try Schedule View
//
//  Created by Nicholas on 28/03/21.
//

import UIKit

//MARK: Protocol to get reuse ID
public protocol Reusable {
    static func ReuseID() -> String
}

// MARK: - Protocol to make header / footer rounded corner
protocol MaskedCorner {
    func maskTopOnlyRoundedCorner(for view: UIView)
    func maskBottomOnlyRoundedCorner(for view: UIView)
}

// MARK: - Implementation for MaskedCorner
extension MaskedCorner {
    func maskTopOnlyRoundedCorner(for view: UIView) {
        view.layer.cornerRadius = Constants.stdCornerRadius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func maskBottomOnlyRoundedCorner(for view: UIView) {
        view.layer.cornerRadius = Constants.stdCornerRadius
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

class CustomHeaderView: UITableViewHeaderFooterView, MaskedCorner {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.maskTopOnlyRoundedCorner(for: self.borderView)
    }
}

extension CustomHeaderView: Reusable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
