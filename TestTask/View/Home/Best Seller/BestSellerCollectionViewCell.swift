//
//  BestSellerCollectionViewCell.swift
//  TestTask
//
//  Created by Антон Шарин on 06.12.2022.
//

import UIKit

class BestSellerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BestSellerCollectionViewCellIdentifier"
    
    private let PhoneimageView : UIImageView =  {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let favoriteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .red
        button.backgroundColor = .white
        button.layer.cornerRadius = 13
        return button
    }()
    

    let TitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Mark Pro", size: 10)
        label.textColor = .black
        return label
    }()
    
    let OldPriceLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let NewPriceLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    func configure(with model : BestSellerViewModel) {
        setup()
        PhoneimageView.sd_setImage(with: URL(string: model.image))
        TitleLabel.text = model.title
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$" + String(format: "%g", model.oldPrice))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        NewPriceLabel.text = "$" + String(format: "%g", model.newPrice)
        OldPriceLabel.attributedText = attributeString
        favoriteButton.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
        contentView.layer.cornerRadius = 10
        createShadow()
    }
    
    private func createShadow() {
        favoriteButton.layer.masksToBounds = false
        favoriteButton.layer.shadowColor = UIColor.black.cgColor
        favoriteButton.layer.shadowOpacity = 0.4
        favoriteButton.layer.shadowOffset = CGSize.zero
        favoriteButton.layer.shadowRadius = 5
        
    }
    
    @objc private func favoriteAction() {
        if favoriteButton.imageView?.image == UIImage(systemName: "heart") {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)

        }
    }
    
    
    private func setup() {
        for element in [PhoneimageView,TitleLabel,OldPriceLabel,NewPriceLabel,favoriteButton] {
            contentView.addSubview(element)

        }
        contentView.backgroundColor = .white
        favoriteButton.frame = CGRect(x: contentView.frame.width * 0.85, y: 10, width: 25, height: 25)
        PhoneimageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height * 0.8)
        NewPriceLabel.frame = CGRect(x: 10, y: PhoneimageView.frame.height, width: 70, height: 20)
        OldPriceLabel.frame = CGRect(x: NewPriceLabel.frame.maxX, y: PhoneimageView.frame.height, width: 70, height: 20)
        TitleLabel.frame = CGRect(x: 10, y: PhoneimageView.frame.maxY + 20, width: contentView.frame.width, height: 20)
        
    }
    
    
    
    
}
