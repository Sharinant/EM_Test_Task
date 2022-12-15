//
//  filterCell.swift
//  TestTask
//
//  Created by Антон Шарин on 15.12.2022.
//

import Foundation
import UIKit


class filterCell: UITableViewCell {
    
    static let identifier = "filterCellIdentifier"

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    
    override func awakeFromNib() {
super.awakeFromNib()
// Initialization code
}
override func setSelected(_ selected: Bool, animated: Bool) {
super.setSelected(selected, animated: animated)
// Configure the view for the selected state
}
    
}
