//
//  Stepper.swift
//  TestTask
//
//  Created by Антон Шарин on 14.12.2022.
//

import Foundation
import UIKit

protocol stepperToVc : AnyObject {
    
    func update(count : Int, method : String) 
    
}

class CustomStepper : UIView {
    
    weak var delegate : stepperToVc?
    
    private var count : Int = 1
    
    private let plusButton : UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private let minusButton : UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private let countLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Mark Pro", size: 20)
        return label
    }()
    
    
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: [minusButton,countLabel,plusButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stack.backgroundColor = UIColor(rgb: 0x282843)
        
        plusButton.addTarget(self, action: #selector(plus), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minus), for: .touchUpInside)

    }
    
    @objc func plus() {
        count += 1
        configLabel()
        delegate?.update(count: count,method: "+")
    }
    
    @objc func minus() {
        if count <= 0 {
            count = 0
        } else {
         count -= 1
        }
        configLabel()
        delegate?.update(count: count,method: "-")
    }
    
     private func configLabel () {
        countLabel.text = String(count)
    }
    
    func start() {
        configLabel()
        configStackView()
    }
}
