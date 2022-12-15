//
//  MyCollectionReusableView.swift
//  TestTask
//
//  Created by Антон Шарин on 07.12.2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableViewIdentifier"
    
    private var size : CGRect?
    
    private let titleSectionLabel : UILabel = {
        let label = UILabel()
        label.text = "im label"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Mark Pro", size: 25)
        //MarkPro-Medium
        
        return label
    }()
    
    private let seeMoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("see more", for: .normal)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(colorOrange, for: .normal)
        button.titleLabel?.font = UIFont(name: "Mark Pro", size: 15)
        return button
    }()
    
    public func configure(with title : String,buttonTitle: String) {
        titleSectionLabel.text = title
        addSubview(titleSectionLabel)
        addSubview(seeMoreButton)
        size = self.frame
        seeMoreButton.setTitle(buttonTitle, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleSectionLabel.frame = CGRect(x: 5, y: 10, width: 200, height: 50)
        seeMoreButton.frame = CGRect(x: size!.maxX - 120, y: 10, width: 100, height: 50)
    }
        
}
