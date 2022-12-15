//
//  DetailViewImagesCollectionViewCell.swift
//  TestTask
//
//  Created by Антон Шарин on 07.12.2022.
//

import UIKit

class DetailViewImagesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailViewImagesCollectionViewCellIdentifier"
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowRadius = 4
        return imageView
    }()
    
    func configure(with image : String) {
        addSubview(imageView)
        imageView.frame = contentView.bounds
        imageView.sd_setImage(with: URL(string: image))
    }
    
}
