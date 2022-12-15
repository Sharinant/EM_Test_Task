//
//  Segment.swift
//  TestTask
//
//  Created by Антон Шарин on 14.12.2022.
//

import Foundation
import UIKit

class CustomSegmentControl : UIView {
    
    convenience init(frame: CGRect,buttonTitles : [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
    }
    
   
    
    func setButtonsTitles(titles : [String]) {
        self.buttonTitles = titles
        updateView()
    }
    
    
    
    
    
    private var buttonTitles : [String] = []
    private var buttons : [UIButton] = []
    private var selectorView : UIView!
    
    
    var textColor = UIColor.gray
    var selectorViewColor = colorOrange
    var selectorTextcolor = colorBlue
    
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    }
    
    private func configSelector() {
        let selectorWidth = frame.width/CGFloat(self.buttonTitles.count)
        
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = []
        subviews.forEach{$0.removeFromSuperview()}
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextcolor, for: .normal)
    }
    
    @objc private func buttonAction(sender : UIButton) {
        for (index,btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextcolor, for: .normal)
            }
        }
    }
    
    private func updateView() {
        createButton()
        configSelector()
        configStackView()
    }
    
}
