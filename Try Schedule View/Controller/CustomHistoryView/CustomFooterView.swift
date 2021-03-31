//
//  CustomFooterView.swift
//  Try Schedule View
//
//  Created by Nicholas on 28/03/21.
//

import UIKit

class CustomFooterView: UITableViewHeaderFooterView, MaskedCorner {
    @IBOutlet var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.maskBottomOnlyRoundedCorner(for: borderView)
    }
}

extension CustomFooterView: Reusable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}
