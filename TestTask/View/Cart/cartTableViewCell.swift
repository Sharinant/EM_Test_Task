//
//  cartTableViewCell.swift
//  TestTask
//
//  Created by Антон Шарин on 08.12.2022.
//

import UIKit

protocol cartCellToCartvc : AnyObject {
    func updatePrice(with price : Double)
    func deleteRow(tag : Int, price : Double)
}

class cartTableViewCell: UITableViewCell {
    
    weak var delegate : cartCellToCartvc?
    
    var currentProductPrice : Double = 0
    var productPrice : Double = 0
    var currentPrice : Double = 0
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var Stepper: CustomStepper!
    @IBOutlet weak var productImage: UIImageView!
    
    
    @IBAction func moveToTrashAction(_ sender: Any) {
        delegate?.deleteRow(tag : self.tag, price: currentProductPrice)
    }
    
    static let identifier = "cartTableViewCellIdentifier"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with data : Busket) {
        Stepper.start()
        Stepper.delegate = self
        Stepper.layer.masksToBounds = true
        Stepper.layer.cornerRadius = 9
        productImage.layer.masksToBounds = true
        productImage.layer.cornerRadius = 10
        productImage.contentMode = .scaleAspectFill
        PriceLabel.textColor = colorOrange
        TitleLabel.text = data.title
        PriceLabel.text = "$" + String(data.price)
        productImage.sd_setImage(with: URL(string: data.image))
        contentView.backgroundColor = colorBlue
        self.productPrice = data.price
        self.currentProductPrice = data.price
        
    }
    
}

extension cartTableViewCell : stepperToVc {
    func update(count: Int, method : String) {
        
        if count == 0 {
            delegate?.deleteRow(tag: self.tag,price: currentProductPrice)
            
        } else {
        
        PriceLabel.text = "$" + String(productPrice * Double(count))
        currentProductPrice = currentProductPrice * Double(count)
      
        switch method {
        case "+":
            currentPrice = productPrice

        case "-":
            currentPrice =  -productPrice

        default:
            break
        }
        delegate?.updatePrice(with: currentPrice)
        }
    }
    
    
}
