//
//  FilterOptions.swift
//  TestTask
//
//  Created by Антон Шарин on 14.12.2022.
//

import UIKit

protocol filter : AnyObject {
    func filter()
    
    func back()
}

var dropDownRowHeight : CGFloat = 50

@IBDesignable
class FilterOptions: UIView {
    
    let dropDown = MakeDropDown()
    var viewModel : [String] = []
    var pickedLabel : Int = 0

    weak var delegate : filter?

    @IBOutlet weak var brandPickerLabel: UILabel!
    @IBOutlet var ContentView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonAction(_ sender: Any) {
        delegate?.back()
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonAction(_ sender: Any) {
        delegate?.back()
    }
    
    @IBOutlet weak var pricePicker: UILabel!
    
    @IBOutlet weak var sizePicker: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
  
    private func commonInit() {
        Bundle.main.loadNibNamed("FilterOptions", owner: self)
        addSubview(ContentView)
        ContentView.frame = self.bounds
        ContentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        setTitle()
        setButtons()
        setLabels()

}
    
    private func setTitle() {
        titleLabel.text = "Filter Options"
        titleLabel.font = UIFont(name: "Mark Pro", size: 18)
    }
    
    private func setButtons() {
        backButton.setTitle("", for: .normal)
        doneButton.setTitle("", for: .normal)
    }
    private func setLabels() {
        
        self.brandPickerLabel.font = UIFont(name: "Mark Pro", size: 18)
        self.pricePicker.font = UIFont(name: "Mark Pro", size: 18)
        self.sizePicker.font = UIFont(name: "Mark Pro", size: 18)
        
        self.brandPickerLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.brandPickerLabel.layer.borderWidth = 0.5
        
        self.pricePicker.layer.borderColor = UIColor.lightGray.cgColor
        self.pricePicker.layer.borderWidth = 0.5
        
        self.sizePicker.layer.borderColor = UIColor.lightGray.cgColor
        self.sizePicker.layer.borderWidth = 0.5

        
        self.brandPickerLabel.isUserInteractionEnabled = true
        let brandLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(brandLabelTap))
        self.brandPickerLabel.addGestureRecognizer(brandLabelTapGesture)
       
        self.pricePicker.isUserInteractionEnabled = true
        let priceLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(priceLabelTap))
        self.pricePicker.addGestureRecognizer(priceLabelTapGesture)
        
        self.sizePicker.isUserInteractionEnabled = true
        let sizeLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(sizeLabelTap))
        self.sizePicker.addGestureRecognizer(sizeLabelTapGesture)
        
        
        

    }
    
    @objc func brandLabelTap(){
    // Give height to drop down according to requirement
    // In this it will show 5 rows in dropdown as per calculations
    self.dropDown.showDropDown(height: dropDownRowHeight * 3)
        config(by: 0)
        pickedLabel = 0
    }
    
    @objc func priceLabelTap(){
    // Give height to drop down according to requirement
    // In this it will show 5 rows in dropdown as per calculations
    self.dropDown.showDropDown(height: dropDownRowHeight * 3)
        config(by: 1)
        pickedLabel = 1
    }
    @objc func sizeLabelTap(){
    // Give height to drop down according to requirement
    // In this it will show 5 rows in dropdown as per calculations
    self.dropDown.showDropDown(height: dropDownRowHeight * 3)
        config(by: 2)
        pickedLabel = 2
    }
    
    func configDrop(with view : CGRect) {
        setUpDropDown(by: view)
    }
    
    func config(by filter : Int) {
        switch filter{
        case 0:
            viewModel = ["Samsung","Xiaomi","Motorola"]
        case 1:
            viewModel = ["$300 - $500","$500 - $1000","$1000 - $1500","$1500 - $10000"]

        case 2:
            viewModel = ["4.5 to 5.5 inches","5.5 to 6.0 inches","6.0 to 6.5 inches"]

        default:
            break
        }
    }
    
    func setUpDropDown(by view : CGRect){
    dropDown.makeDropDownIdentifier = "DROP_DOWN_NEW"
    dropDown.makeDropDownDataSourceProtocol = self
    dropDown.setUpDropDown(viewPositionReference: (view), offset: 0)
    dropDown.nib = UINib(nibName: "BrandTableViewCell", bundle: nil)
    // dropDownRowHeight is global variable with constant value 50,
   // you can give any value depending upon how much row height you want in dropdown menu.
    dropDown.setRowHeight(height: dropDownRowHeight)
        dropDown.width = view.width / 2
        print(dropDown.width)
    self.addSubview(dropDown)
    }
}

extension FilterOptions: MakeDropDownDataSourceProtocol{
    
func getDataToDropDown(cell: UITableViewCell, indexPos: Int, makeDropDownIdentifier: String) {
    
if makeDropDownIdentifier == "DROP_DOWN_NEW" {
let customCell = cell as! BrandTableViewCell
    customCell.brandLabel.text = viewModel[indexPos]

}
}
func numberOfRows(makeDropDownIdentifier: String) -> Int {
    return 3
}
func selectItemInDropDown(indexPos: Int, makeDropDownIdentifier: String) {
    
    switch pickedLabel {
    case 0:
        self.brandPickerLabel.text = viewModel[indexPos]

    case 1:
        self.pricePicker.text = viewModel[indexPos]

    case 2:
        self.sizePicker.text = viewModel[indexPos]

    default:
        break
    }
self.dropDown.hideDropDown()
}
}
