//
//  FinderCollectionViewCell.swift
//  TestTask
//
//  Created by Антон Шарин on 07.12.2022.
//

import UIKit

class FinderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ButtonOutlet: UIButton!
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var buttonAction: UIButton!
  
    
    static let identifier = "FinderCollectionViewCellIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ButtonOutlet.setTitle("", for: .normal)
        textFieldOutlet.delegate = self
        textFieldOutlet.layer.cornerRadius = 10
    }

}

extension FinderCollectionViewCell : UITextFieldDelegate{
    
}
