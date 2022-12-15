//
//  DetailsViewController.swift
//  TestTask
//
//  Created by Антон Шарин on 06.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    weak var coordinator : AppCoordinator?
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBAction func likeButtonAction(_ sender: Any) {
        changeLikeButton()
    }
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var NavBar: HomeNavigationBar!
    @IBOutlet weak var cpuLabel: UILabel!
    

    @IBOutlet weak var sdLabel: UILabel!
    @IBOutlet weak var ramLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var collectionViewPictures: UICollectionView!
    @IBOutlet weak var detailInfoView: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBAction func addToCartAction(_ sender: Any) {
        
        
        
    }
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var storageSegment: UISegmentedControl!
    
    
    @IBOutlet weak var colorButtonLeft: UIButton!
    
    @IBOutlet weak var colorButtonRight: UIButton!
    
    @IBOutlet weak var segment: CustomSegmentControl!
    
    @IBAction func rightButtonColorAction(_ sender: Any) {
        setRightButton()
    }
    @IBAction func leftButtonColorAction(_ sender: Any) {
        setLeftButton()
    }
    let viewModel = DetailViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true

    }
    
    private func setRightButton() {
        colorButtonRight.layer.borderColor = UIColor.blue.cgColor
        colorButtonRight.layer.borderWidth = 4
        colorButtonLeft.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setLeftButton() {
        colorButtonLeft.layer.borderColor = UIColor.blue.cgColor
        colorButtonLeft.layer.borderWidth = 4
        colorButtonRight.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backColor
        viewModel.getData()
        viewModel.delegate = self
        setupCollection()
        setNavBar()
        setBackView()
        setLikeButton()
        segment.setButtonsTitles(titles: ["Shop","Details","Features"])
        segment.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    private func setLikeButton() {
        likeButton.setTitle("", for: .normal)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .red
    }
    
    private func changeLikeButton() {
        if likeButton.imageView?.image == UIImage(systemName: "heart") {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)

        }
    }
    
    private func setBackView() {
        detailInfoView.layer.cornerRadius = 30
        detailInfoView.layer.masksToBounds = false
        detailInfoView.layer.shadowColor = UIColor.black.cgColor
        detailInfoView.layer.shadowOpacity = 0.2
        detailInfoView.layer.shadowOffset = CGSize.zero
        detailInfoView.layer.shadowRadius = 3
    }
    
    private func setNavBar() {
        NavBar.delegate = self
        NavBar.backgroundColor = backColor
        NavBar.ContentView.backgroundColor = backColor
        NavBar.RightButton.setTitle("", for: .normal)
        //NavBar.BackButton.isHidden = true
        NavBar.AddAdressLabel.isHidden = true
        NavBar.MiddleButton.isHidden = false
       setupMiddleButton()
        NavBar.RightButton.setImage(UIImage(named: "cart-1.png"), for: .normal)
        NavBar.locImage.isHidden = true
       
    }
    
    private func setupMiddleButton() {
        let myString = "Product Details"
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont(name: "Mark Pro", size: 18) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute as [NSAttributedString.Key : Any])
        NavBar.MiddleButton.setAttributedTitle(myAttrString, for: .normal)
    }
    
    private func setupCollection() {
        collectionViewPictures.register(DetailViewImagesCollectionViewCell.self, forCellWithReuseIdentifier: DetailViewImagesCollectionViewCell.identifier)
        collectionViewPictures.delegate = self
        collectionViewPictures.dataSource = self
        collectionViewPictures.collectionViewLayout = createCompositionalLayout()
        collectionViewPictures.backgroundColor = backColor
        
        
        
    }
    
    private func buttonsLayer() {
        colorButtonLeft.setTitle("", for: .normal)
        colorButtonRight.setTitle("", for: .normal)
        colorButtonLeft.layer.cornerRadius = colorButtonLeft.frame.height/2
        colorButtonRight.layer.cornerRadius = colorButtonRight.frame.height/2
        

    }
    
    private func configure(with model : DetailViewViewModel) {
        colorButtonLeft.backgroundColor = hexStringToUIColor(hex: model.color[0])
        colorButtonRight.backgroundColor = hexStringToUIColor(hex: model.color[1])
        productNameLabel.text = model.title
        buttonsLayer()
        cpuLabel.text = model.cpu
        cameraLabel.text = model.camera
        ramLabel.text = model.ssd
        sdLabel.text = model.sd
        rateLabel.text = String(model.rating)
       
        storageSegment.setTitle(model.capacity[0] + " GB", forSegmentAt: 0)
        storageSegment.selectedSegmentTintColor = colorOrange
        storageSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        storageSegment.tintColor = .white
        storageSegment.setTitle(model.capacity[1] + " GB", forSegmentAt: 1)
        addToCartButton.setTitle("Add to Cart" + "     " + "$" + String(model.price) , for: .normal)
        addToCartButton.backgroundColor = colorOrange
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.font = UIFont(name: "Mark Pro", size: 20)
        addToCartButton.layer.cornerRadius = 10
    }
    
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createLayout()
        }
        
        return layout
    }
    
    func createLayout() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 5, bottom: 10, trailing: 5)
        return section
    }


}

extension DetailsViewController : DetailViewModelToView {
    func updateUI(with: DetailViewViewModel) {
        configure(with: with)
        collectionViewPictures.reloadData()
    }
    
   
}

extension DetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewPictures.dequeueReusableCell(withReuseIdentifier: DetailViewImagesCollectionViewCell.identifier, for: indexPath) as? DetailViewImagesCollectionViewCell else {return UICollectionViewCell()}
        
        cell.configure(with: viewModel.giveImage(for: indexPath.row))
        return cell
    }
    
    
}

extension DetailsViewController : NavBarDelegate {
    func leftAction() {
        coordinator?.back()
    }
    
    func rightAction() {
        
    }
    
    
}
