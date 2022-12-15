//
//  NavBar.swift
//  TestTask
//
//  Created by Антон Шарин on 05.12.2022.
//

import Foundation
import UIKit

protocol NavBarDelegate : AnyObject {
    func leftAction()
    func rightAction()
}

@IBDesignable
class HomeNavigationBar : UIView {
  
    weak var delegate : NavBarDelegate?
    
    @IBOutlet var ContentView: UIView!
    
    @IBAction func leftButtonAction(_ sender: UIButton) {
        delegate?.leftAction()
    }
    @IBOutlet weak var locImage: UIImageView!
    @IBOutlet weak var MiddleButton: UIButton!
    @IBOutlet weak var AddAdressLabel: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        delegate?.rightAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
        let bundle = Bundle(for: HomeNavigationBar.self)
        bundle.loadNibNamed("HomeNavigationBar", owner: self)
        BackButton.setTitle("", for: .normal)
        addSubview(ContentView)
        ContentView.frame = self.bounds
        ContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    

}
