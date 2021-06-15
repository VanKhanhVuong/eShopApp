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
    
    private var homeViewModel = HomeViewModel()
    private var cartViewModel = CartViewModel()
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        slideCollectionView.delegate = self
        exclusiveOfferCollectionView.delegate = self
        bestSellingCollectionView.delegate = self
        cheapProductsCollectionView.delegate = self
        categoryCollectionView.delegate = self
        
        slideCollectionView.dataSource = self
        exclusiveOfferCollectionView.dataSource = self
        bestSellingCollectionView.dataSource = self
        cheapProductsCollectionView.dataSource = self
        categoryCollectionView.dataSource = self
        
        homeViewModel.delegate = self
        cartViewModel.delegate = self
        exclusiveOfferView.delegate = self
        bestSellingView.delegate = self
        cheapProductsView.delegate = self
        categoryProductView.delegate = self
        
        homeViewModel.loadItemProduct()
        homeViewModel.loadCategory()
        
        slideCollectionView.register(cellType: SlideCollectionViewCell.self)
        exclusiveOfferCollectionView.register(cellType: ItemCollectionViewCell.self)
        bestSellingCollectionView.register(cellType: ItemCollectionViewCell.self)
        cheapProductsCollectionView.register(cellType: ItemCollectionViewCell.self)
        categoryCollectionView.register(cellType: CategoryCollectionViewCell.self)
        
        categoryProductView.categoryTitleLabel.text = BaseProduct.categoryProduct.rawValue
        exclusiveOfferView.categoryTitleLabel.text = BaseProduct.exclusiveOffer.rawValue
        bestSellingView.categoryTitleLabel.text = BaseProduct.bestSelling.rawValue
        cheapProductsView.categoryTitleLabel.text = BaseProduct.cheapProducts.rawValue
        
        
        // pageControl's number of pages is equal to the total number of arrayPoster elements it has.
        slidePageControl.numberOfPages = homeViewModel.arrayPoster.count
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 15
    }
    
    private func navigationTypeProductScreen(title: String) {
        let mainStoryboard = UIStoryboard(name: "TypeProduct", bundle: .main)
        guard let typeProductViewController = mainStoryboard.instantiateViewController(withIdentifier: "TypeProductView") as? TypeProductViewController else { return }
        typeProductViewController.nameCategory = title
        switch title {
        case BaseProduct.exclusiveOffer.rawValue:
            typeProductViewController.typeProductViewModel.arrayProduct = homeViewModel.arrayProductExclusive
        case BaseProduct.bestSelling.rawValue:
            typeProductViewController.typeProductViewModel.arrayProduct = homeViewModel.arrayProductBestSelling
        case BaseProduct.cheapProducts.rawValue:
            typeProductViewController.typeProductViewModel.arrayProduct = homeViewModel.arrayProductCheap
        default:
            typeProductViewController.typeProductViewModel.arrayProduct = homeViewModel.arrayProductByCategory
        }
        typeProductViewController.modalPresentationStyle = .fullScreen
        present(typeProductViewController, animated: true, completion: nil)
    }
    
    private func navigationDetail(name: String, index: IndexPath) {
            let mainStoryboard = UIStoryboard(name: "Detail", bundle: .main)
            guard let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else { return }
            detailViewController.modalPresentationStyle = .fullScreen
            switch name {
            case BaseProduct.exclusiveOffer.rawValue:
                detailViewController.detailViewModel.itemProduct = homeViewModel.arrayProductExclusive[index.item]
            case BaseProduct.bestSelling.rawValue:
                detailViewController.detailViewModel.itemProduct = homeViewModel.arrayProductBestSelling[index.item]
            case BaseProduct.cheapProducts.rawValue:
                detailViewController.detailViewModel.itemProduct = homeViewModel.arrayProductCheap[index.item]
            default:
                break
            }
            present(detailViewController, animated: true, completion: nil)
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
            homeViewModel.loadItemProductByCategory(categoryId: homeViewModel.arrayCategoryId[indexPath.row], categoryName: homeViewModel.arrayNameCategory[indexPath.row])
        case exclusiveOfferCollectionView:
            navigationDetail(name: BaseProduct.exclusiveOffer.rawValue, index: indexPath)
        case bestSellingCollectionView:
            navigationDetail(name: BaseProduct.bestSelling.rawValue, index: indexPath)
        case cheapProductsCollectionView:
            navigationDetail(name: BaseProduct.cheapProducts.rawValue, index: indexPath)
        default:
            break
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
            return homeViewModel.arrayImageCategory.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case exclusiveOfferCollectionView, cheapProductsCollectionView, bestSellingCollectionView:
            let productCell = collectionView.dequeueReusableCell(with: ItemCollectionViewCell.self, for: indexPath)
            switch collectionView {
            case exclusiveOfferCollectionView:
                let productExclusive = homeViewModel.arrayProductExclusive[indexPath.item]
                productCell.configure(item: productExclusive)
            case cheapProductsCollectionView:
                let productCheap = homeViewModel.arrayProductCheap[indexPath.item]
                productCell.configure(item: productCheap)
            case bestSellingCollectionView:
                let productBestSelling = homeViewModel.arrayProductBestSelling[indexPath.item]
                productCell.configure(item: productBestSelling)
            default:
                break
            }
            productCell.delegate = self
            return productCell
        case slideCollectionView:
            let posterCell = collectionView.dequeueReusableCell(with: SlideCollectionViewCell.self, for: indexPath)
            let poster = homeViewModel.arrayPoster[indexPath.item]
            posterCell.configure(urlString: poster)
            return posterCell
        case categoryCollectionView:
            let categoryCell = collectionView.dequeueReusableCell(with: CategoryCollectionViewCell.self, for: indexPath)
            let image = homeViewModel.arrayImageCategory[indexPath.item]
            let name = homeViewModel.arrayNameCategory[indexPath.item]
            let color = homeViewModel.arrayColorBackground[indexPath.item]
            categoryCell.configure(name: name, image: image, color: color)
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
            return CGSize(width: (collectionView.frame.width - 15) / 1.5, height: collectionView.frame.height)
        default:
            return CGSize(width: (exclusiveOfferCollectionView.frame.width - 45) / 2, height: exclusiveOfferCollectionView.frame.height - 20)
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
    func gotData(isCategory: Bool, categoryName: String) {
        DispatchQueue.main.async {
            if isCategory {
                self.navigationTypeProductScreen(title: categoryName)
            } else {
                self.exclusiveOfferCollectionView.reloadData()
                self.bestSellingCollectionView.reloadData()
                self.cheapProductsCollectionView.reloadData()
            }
        }
    }
    
    func gotError(messageError: ErrorModel) {}
}

extension HomeViewController: ItemCollectionViewCellEvents {
    func addCart(item: ItemCollectionViewCell) {
        self.cartViewModel.filterProductCart(productId: item.idProduct, amount: "1", isCart: false, userId: self.getUserId())
    }
}

extension HomeViewController: CategoryViewEvents {
    func gotData(title: String) {
        if title == BaseProduct.categoryProduct.rawValue {
            print("Show Explore Screen")
        } else {
            self.navigationTypeProductScreen(title: title)
        }
    }
}

extension HomeViewController: CartViewModelEvents {
    func gotIdOrder() {}
    
    func gotErrorCart(messageError: String) {
        DispatchQueue.main.async {
            self.showAlert(message: messageError)
        }
    }
    
    func gotAmountProduct(amount: String) {
        print("Get amount product in cart")
    }
    
    func gotDataCart(messageChangeData: String) {
        DispatchQueue.main.async {
            if !messageChangeData.isEmpty {
                self.showAlert(message: messageChangeData)
            }
        }
    }
}

