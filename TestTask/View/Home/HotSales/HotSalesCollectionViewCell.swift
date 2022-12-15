//
//  HotSalesCollectionViewCell.swift
//  TestTask
//
//  Created by Антон Шарин on 06.12.2022.
//

import UIKit
import SDWebImage

class HotSalesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HotSalesCollectionViewCellIdentifier"
    
    private let ButtonBuy : UIButton = {
        let button = UIButton()
        button.setTitle("Buy Now !", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        
        
        return button
    }()
    
    private let PhoneimageView : UIImageView =  {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let NewImageView : UIImageView =  {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "New.png")
        
        return imageView
    }()
    
    let TitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25)

        return label
    }()
    
    let SubtitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
  
    
    func configure(with model : HotSalesViewModel) {
        setup()
       // PhoneimageView.image = model.phoneImage
        PhoneimageView.sd_setImage(with: URL(string: model.phoneImageUrl))
        TitleLabel.text = model.title
        SubtitleLabel.text = model.subTitle
        
        if model.isNew ?? false {
            NewImageView.isHidden = false
        }
        NotificationCenter.default.post(name: NSNotification.Name("123"), object: nil)
        
    }
    
    private func setup() {
        for element in [PhoneimageView,NewImageView,TitleLabel,SubtitleLabel,ButtonBuy] {
            contentView.addSubview(element)

        }
        NewImageView.isHidden = true
        PhoneimageView.frame = contentView.bounds
        NewImageView.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        TitleLabel.frame = CGRect(x: 10, y: 50, width: 300, height: 26)
        SubtitleLabel.frame = CGRect(x: 10, y: TitleLabel.frame.maxY, width: 150, height: 26)
        ButtonBuy.frame = CGRect(x: 10, y: SubtitleLabel.frame.maxY, width: 100, height: 20)
        
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
