//
//  CartViewController.swift
//  TestTask
//
//  Created by Антон Шарин on 03.12.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    var curPrice : Double = 0
    
    weak var coordinator : AppCoordinator?
    
    let viewModel = CartViewModel()

    @IBOutlet weak var ChecoutButton: UIButton!
    @IBOutlet weak var myCartLabel: UILabel!
    @IBOutlet weak var NavBar: HomeNavigationBar!
    @IBOutlet weak var DeliveryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartTable: UITableView!
    
    @IBOutlet weak var backGroundView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backColor
        viewModel.getData()
        viewModel.delegate = self
        backGroundView.backgroundColor = colorBlue
        backGroundView.layer.cornerRadius = 15
        registerTable()
        setNavBar()
        setButton()
        // Do any additional setup after loading the view.
    }
    
    private func setButton() {
        ChecoutButton.backgroundColor = colorOrange
        ChecoutButton.layer.cornerRadius = 10
        
        let myString = "Checkout"
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont(name: "Mark Pro", size: 18) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute as [NSAttributedString.Key : Any])
        
        ChecoutButton.setAttributedTitle(myAttrString, for: .normal)
        
    }
    
    private func setNavBar() {
        NavBar.delegate = self
        NavBar.backgroundColor = backColor
        NavBar.ContentView.backgroundColor = backColor
        NavBar.RightButton.setTitle("", for: .normal)
        //NavBar.BackButton.isHidden = true
        NavBar.AddAdressLabel.isHidden = false
        NavBar.MiddleButton.isHidden = true
        NavBar.RightButton.setImage(UIImage(named: "location.png"), for: .normal)
        NavBar.RightButton.setBackgroundImage(UIImage(named: "location"), for: .normal)
        NavBar.locImage.isHidden = true
        NavBar.AddAdressLabel.font = UIFont(name: "Mark Pro", size: 18)
        NavBar.AddAdressLabel.textColor = .black
        myCartLabel.textColor = colorBlue
    }
    

    private func registerTable() {
        
        cartTable.register(UINib(nibName: "cartTableViewCell", bundle: nil), forCellReuseIdentifier: cartTableViewCell.identifier)
        cartTable.dataSource = self
        cartTable.delegate = self
        cartTable.backgroundColor = colorBlue
    }

}

extension CartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cartTable.dequeueReusableCell(withIdentifier: cartTableViewCell.identifier, for: indexPath) as? cartTableViewCell else {return UITableViewCell()}
        
        let data = viewModel.busketDataToCell(for: indexPath.row)
        cell.delegate = self
        cell.configure(with: data)
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}

extension CartViewController : cartViewModelToView {
    func updateUI(with data: CartViewViewModel) {
        DispatchQueue.main.async {
            self.cartTable.reloadData()
            self.DeliveryLabel.text = data.delievery
            self.priceLabel.text = "$"+String(data.total) + " us"
            self.curPrice = data.total
        }
    }
    
    
}

extension CartViewController : NavBarDelegate {
    
    func leftAction() {
        tabBarController?.selectedIndex = 0
        
    }
    
    func rightAction() {
        
    }
    
    
}

extension CartViewController : cartCellToCartvc {
    func deleteRow(tag: Int, price: Double) {
        viewModel.deleteAtIndex(index: tag)
        cartTable.reloadData()
        
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[1]
            if cartTable.rowsCount == 0 {
                tabItem.badgeValue = nil

            } else {
            tabItem.badgeValue = String(cartTable.rowsCount)
            }
        }
       
        curPrice = curPrice - price
        self.priceLabel.text = "$"+String(curPrice) + " us"


    }
    
   
    
   
    
    func updatePrice(with price: Double) {
        self.curPrice = curPrice + price
        self.priceLabel.text = "$"+String(curPrice) + " us"
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[1]
            tabItem.badgeValue = String(cartTable.rowsCount)
        }
    
    
    }
    
    
    
    
}

extension UITableView {

    var rowsCount: Int {
        let sections = self.numberOfSections
        var rows = 0

        for i in 0...sections - 1 {
            rows += self.numberOfRows(inSection: i)
        }

        return rows
    }
}
