//
//  HomeViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 17/05/2021.
//

import UIKit


class HomeViewController: UIViewController {
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet weak var slidePageControl: UIPageControl!
    @IBOutlet weak var exclusiveOfferView: CategoryView!
    @IBOutlet weak var bestSellingView: CategoryView!
    @IBOutlet weak var cheapProductsView: CategoryView!
    @IBOutlet weak var categoryProductView: CategoryView!
    @IBOutlet weak var exclusiveOfferCollectionView: UICollectionView!
    @IBOutlet weak var bestSellingCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var cheapProductsCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    
    private var homeViewModel = HomeViewModel()
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            setupView()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 13.0, *)
    private func setupView() {
        slideCollectionView.delegate = self
        exclusiveOfferCollectionView.delegate = self
        bestSellingCollectionView.delegate = self
        cheapProductsCollectionView.delegate = self
        categoryCollectionView.delegate = self
        homeViewModel.delegate = self
        
        slideCollectionView.dataSource = self
        exclusiveOfferCollectionView.dataSource = self
        bestSellingCollectionView.dataSource = self
        cheapProductsCollectionView.dataSource = self
        categoryCollectionView.dataSource = self
        
        homeViewModel.loadItemProduct()
        homeViewModel.loadItemCategory()
        
        slideCollectionView.register(cellType: SlideCollectionViewCell.self)
        exclusiveOfferCollectionView.register(cellType: ItemCollectionViewCell.self)
        bestSellingCollectionView.register(cellType: ItemCollectionViewCell.self)
        cheapProductsCollectionView.register(cellType: ItemCollectionViewCell.self)
        categoryCollectionView.register(cellType: CategoryCollectionViewCell.self)
        
        categoryProductView.categoryTitleLabel.text = "Category Product"
        exclusiveOfferView.categoryTitleLabel.text = "Exclusive Offer"
        bestSellingView.categoryTitleLabel.text = "Best Selling"
        cheapProductsView.categoryTitleLabel.text = "Cheap Products"
        
        // pageControl's number of pages is equal to the total number of arrayPoster elements it has.
        slidePageControl.numberOfPages = homeViewModel.arrayPoster.count
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 15
        
        navigationSignIn()
        cornerRadiusLoginView()
    }
    
    func cornerRadiusLoginView() {
        loginView.clipsToBounds = true
        loginView.layer.cornerRadius = 15
        loginView.layer.maskedCorners = .layerMaxXMinYCorner
    }
    
    @available(iOS 13.0, *)
    func navigationSignIn() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        loginLabel.addGestureRecognizer(tap)
    }
    
    @available(iOS 13.0, *)
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let mainStoryboard = UIStoryboard(name: "SignIn", bundle: .main)
        guard let signInViewController = mainStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
        signInViewController.modalPresentationStyle = .fullScreen
        present(signInViewController, animated: true, completion: nil)
    }
}


extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(slideCollectionView), scrollView.isDragging {
            currentIndex = Int(scrollView.contentOffset.x / slideCollectionView.frame.size.width)
            slidePageControl.currentPage = currentIndex
        } else {
            // When Scrolling other CollectionViews slideCollectionView.
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case slideCollectionView:
            return
        case categoryCollectionView:
            return
        default:
            if #available(iOS 13.0, *) {
                let mainStoryboard = UIStoryboard(name: "Detail", bundle: .main)
                guard let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else { return }
                detailViewController.modalPresentationStyle = .fullScreen
                detailViewController.detailViewModel.itemProduct = homeViewModel.arrayProductExclusive[indexPath.item]
                present(detailViewController, animated: true, completion: nil)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case exclusiveOfferCollectionView:
            return homeViewModel.arrayProductExclusive.count
        case bestSellingCollectionView:
            return homeViewModel.arrayProductBestSelling.count
        case cheapProductsCollectionView:
            return homeViewModel.arrayProductCheap.count
        case slideCollectionView:
            return homeViewModel.arrayPoster.count
        case categoryCollectionView:
            return homeViewModel.arrayCategory.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case exclusiveOfferCollectionView:
            let productCell = collectionView.dequeueReusableCell(with: ItemCollectionViewCell.self, for: indexPath)
            let product = homeViewModel.arrayProductExclusive[indexPath.item]
            productCell.configure(item: product)
            return productCell
        case cheapProductsCollectionView:
            let productCell = collectionView.dequeueReusableCell(with: ItemCollectionViewCell.self, for: indexPath)
            let product = homeViewModel.arrayProductCheap[indexPath.item]
            productCell.configure(item: product)
            return productCell
        case bestSellingCollectionView:
            let productCell = collectionView.dequeueReusableCell(with: ItemCollectionViewCell.self, for: indexPath)
            let product = homeViewModel.arrayProductBestSelling[indexPath.item]
            productCell.configure(item: product)
            return productCell
        case slideCollectionView:
            let posterCell = collectionView.dequeueReusableCell(with: SlideCollectionViewCell.self, for: indexPath)
            let poster = homeViewModel.arrayPoster[indexPath.item]
            posterCell.configure(urlString: poster)
            return posterCell
        case categoryCollectionView:
            let categoryCell = collectionView.dequeueReusableCell(with: CategoryCollectionViewCell.self, for: indexPath)
            let category = homeViewModel.arrayCategory[indexPath.item]
            categoryCell.configure(item: category)
            return categoryCell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case slideCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case categoryCollectionView:
            return CGSize(width: collectionView.frame.width - 120, height: collectionView.frame.height)
        default:
            return CGSize(width: (collectionView.frame.width - 45) / 2, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case slideCollectionView:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case categoryCollectionView:
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        default:
            return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }
    }
}

extension HomeViewController: HomeViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            self.exclusiveOfferCollectionView.reloadData()
            self.bestSellingCollectionView.reloadData()
            self.cheapProductsCollectionView.reloadData()
            self.categoryCollectionView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}


