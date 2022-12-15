//
//  ViewController.swift
//  TestTask
//
//  Created by Антон Шарин on 03.12.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var NavBar: HomeNavigationBar!
    weak var coordinator : AppCoordinator?
    
    let containerView = UIView()
    let filtersView = FilterOptions()

    
    enum section {
        case category
        case finder
        case hotSales
        case bestSeller
    }
    
    let sections : [section] = [.category,.hotSales,.bestSeller]
  
    
    let screenSize = UIScreen.main.bounds.size
    
    let viewModel = HomeViewModel()
    
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)


  
    @IBOutlet weak var MainCollectionView: UICollectionView!
   // @IBOutlet weak var CustomNavigationBarOutlet: HomeNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleButton()
        viewModel.delegate = self
        configureCollection()
        viewModel.testData()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(stopAnimating), name: NSNotification.Name("123"), object: nil)
        MainCollectionView.backgroundColor = backColor
        setNavBar()
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[1]
            tabItem.badgeValue = "2"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setToolbarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false

//        self.view.addSubview(filtersView)
        self.view.addSubview(containerView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }
    
    private func setNavBar() {
        NavBar.delegate = self
        NavBar.backgroundColor = backColor
        NavBar.ContentView.backgroundColor = backColor
        NavBar.RightButton.setTitle("", for: .normal)
        //NavBar.tintColor = backColor
        NavBar.BackButton.isHidden = true
        NavBar.AddAdressLabel.isHidden = true
        NavBar.locImage.isHidden = false
    }
    
  
    
    private func setupMiddleButton() {
        let myString = "Moscow"
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font : UIFont(name: "Mark Pro", size: 18) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute as [NSAttributedString.Key : Any])
        NavBar.MiddleButton.setAttributedTitle(myAttrString, for: .normal)
    }
    
    @objc private func stopAnimating() {
        activityIndicatorView.stopAnimating()
        print("hello")
    }
    
    private func goToDetailView(for index: Int) {
        coordinator?.goToDetailPage(for: index)
    }
    
    private func changeCellsCategory(selected : Int){
        let array = [0,1,2,3,4]
        array.forEach { index in
            let cell = MainCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! CategoryCollectionViewCell
            cell.changeColorToSelected()
            if index == selected {
                cell.changeColorToSelected()
            } else {
                cell.changeBackColorToDefaul()
            }
        }
      //  MainCollectionView.reloadData()
    }
    
    private func configureCollection() {
       
        //Register
        MainCollectionView.delegate = self
        MainCollectionView.dataSource = self
        MainCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        MainCollectionView.register(HotSalesCollectionViewCell.self, forCellWithReuseIdentifier: HotSalesCollectionViewCell.identifier)
        MainCollectionView.register(BestSellerCollectionViewCell.self, forCellWithReuseIdentifier: BestSellerCollectionViewCell.identifier)
        MainCollectionView.register(UINib(nibName: "FinderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FinderCollectionViewCell.identifier)
        
        MainCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellTest")
        
        MainCollectionView.collectionViewLayout = createCompositionalLayout()
        
        
        MainCollectionView.register(HeaderCollectionReusableView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        MainCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        

        
    }
    
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let supplementaryViews = [NSCollectionLayoutBoundarySupplementaryItem(
                                          layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .absolute(70)),
                                          elementKind: UICollectionView.elementKindSectionHeader,
                                          alignment: .top)]
        
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                let section = self.createCategorySection()
                section.boundarySupplementaryItems = supplementaryViews
                return section
                
            case 1:
                let section = self.createFinderCollection()
                return section
                
            case 2:
                let section = self.createHotSalesSection()
                section.boundarySupplementaryItems = supplementaryViews

                return section
                
            case 3:
                let section = self.createBestSellerCollection()
                section.boundarySupplementaryItems = supplementaryViews

                return section


            default:
                return self.createHotSalesSection()

            }
        }
        
        return layout
    }

    
    func createCategorySection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.1),
            heightDimension: .estimated(100))
     
        
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        
        
        let section = NSCollectionLayoutSection(group: group1)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 10, trailing: 0)
        return section
    }
    
    func createHotSalesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
    
    func createBestSellerCollection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 15, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250))
        
        
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        
        let section = NSCollectionLayoutSection(group: group1)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
    
    func createFinderCollection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40))
      
        
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        
        let section = NSCollectionLayoutSection(group: group1)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    

   private func filterPush(){
       filtersView.delegate = self
       self.view.addSubview(filtersView)
       filtersView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 400)
       filtersView.configDrop(with: self.filtersView.brandPickerLabel.frame)

       containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
       containerView.frame = self.view.frame
       let tapGesture = UITapGestureRecognizer(target: self,
                           action: #selector(slideUpViewTapped))
         containerView.addGestureRecognizer(tapGesture)
       
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.filtersView.frame.origin.y -= 400
            self.tabBarController?.tabBar.isHidden = true
            self.containerView.alpha = 0.8
        }
}
    @objc func slideUpViewTapped() {
      UIView.animate(withDuration: 0.5,
                     delay: 0, usingSpringWithDamping: 1.0,
                     initialSpringVelocity: 1.0,
                     options: .curveEaseInOut, animations: {
        self.containerView.alpha = 0
          self.filtersView.frame.origin.y += 400
          self.filtersView.removeFromSuperview()
          self.tabBarController?.tabBar.isHidden = false


      }, completion: nil)
}
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            changeCellsCategory(selected: indexPath.row)
        case 1:
            break
        case 2:
            break
        case 3:
            goToDetailView(for: indexPath.row)
        default :
            break
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 1
        case 2:
            return viewModel.getNumberOfItemsHotSales()
        case 3:
            return viewModel.getNumberOfItemsBestSeller()
        default:
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = MainCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
            let category = viewModel.getCategory(for: indexPath.row)
            cell.configure(with: category.1, image: category.0)
            if indexPath.row == 0 {
                cell.changeColorToSelected()
            }
            return cell
        case 1:
            guard let cell = MainCollectionView.dequeueReusableCell(withReuseIdentifier: FinderCollectionViewCell.identifier, for: indexPath) as? FinderCollectionViewCell else {return UICollectionViewCell()}
            
            return cell
        case 2:
            guard let cell = MainCollectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCollectionViewCell.identifier, for: indexPath) as? HotSalesCollectionViewCell else {return UICollectionViewCell()}
            
            cell.configure(with: viewModel.getHotSalesViewModel(for: indexPath.row))
            return cell
        case 3:
            guard let cell = MainCollectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCollectionViewCell.identifier, for: indexPath) as? BestSellerCollectionViewCell else {return UICollectionViewCell()}
            
            cell.configure(with: viewModel.getBestSellerViewModel(for: indexPath.row))
            return cell
        default:
            let cell = MainCollectionView.dequeueReusableCell(withReuseIdentifier: "cellTest", for: indexPath)
            cell.backgroundColor = .red
            return cell
            
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = MainCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        switch indexPath.section {
        case 0:
            header.configure(with: "Select Category", buttonTitle: "view all")

        case 1:
            header.configure(with: "", buttonTitle: "")

        case 2:
            header.configure(with: "Hot Sales", buttonTitle: "see more")

        case 3:
            header.configure(with: "Best Sellers", buttonTitle: "see more")

        default:
            break
        }
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenSize.width, height: 50)
    }

}

extension HomeViewController : HomeViewModelToView {
    func updateUI() {
        DispatchQueue.main.async {
            self.MainCollectionView.reloadData()
        }
    }
}


extension HomeViewController : NavBarDelegate {
    func leftAction() {
        print("left")
    }
    
    func rightAction() {
        filterPush()
    }
    
    
}

extension HomeViewController : filter {
    func filter() {
        
    }
    
    func back() {
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
          self.containerView.alpha = 0
            self.filtersView.frame.origin.y += 400
            self.filtersView.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
    }
    
    
)}
        }
