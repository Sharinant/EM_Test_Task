//
//  CustomTabBar.swift
//  TestTask
//
//  Created by Антон Шарин on 13.12.2022.
//

import UIKit

@IBDesignable class CustomTabBar: UIView {

 
    @IBOutlet var backView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
        let bundle = Bundle(for: CustomTabBar.self)
        bundle.loadNibNamed("CustomTabBar", owner: self)
    
        
    }
    
}
