//
//  CategoryCollectionViewCell.swift
//  TestTask
//
//  Created by Антон Шарин on 05.12.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var CategoryName: UILabel!
    @IBOutlet weak var CategoryImage: UIImageView!
    static let identifier = "CategoryCollectionViewCellIdentifier"
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with title: String, image : UIImage) {
        setTitle(title: title)
        SetImage(image: image)
        BackView.layer.cornerRadius = BackView.frame.height/2
        print("configure cell")
        createShadow()
    }
    
    private func setTitle(title : String) {
        CategoryName.text = title
    }
    
    private func SetImage(image : UIImage) {
        CategoryImage.image = image
    }
    
    private func createShadow() {
        BackView.layer.masksToBounds = false
        BackView.layer.shadowColor = UIColor.black.cgColor
        BackView.layer.shadowOpacity = 0.2
        BackView.layer.shadowOffset = CGSize.zero
        BackView.layer.shadowRadius = 3
        

    }
    
    func changeState() {
        if BackView.backgroundColor == .white {
            changeColorToSelected()
        } else {
            changeBackColorToDefaul()
        }
    }
    
     func changeBackColorToDefaul() {
        BackView.backgroundColor = .white
        CategoryName.textColor = .black
    }
    
     func changeColorToSelected() {
        BackView.backgroundColor = colorOrange
        CategoryName.textColor = colorOrange
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        BackView.backgroundColor = .white
        CategoryName.textColor = .black
    }

}
