//
//  BrandTableViewCell.swift
//  TestTask
//
//  Created by Антон Шарин on 15.12.2022.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    static let identifier = "BrandTableViewCell"
    
    @IBOutlet weak var brandLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        brandLabel.font = UIFont(name: "Mark Pro", size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
