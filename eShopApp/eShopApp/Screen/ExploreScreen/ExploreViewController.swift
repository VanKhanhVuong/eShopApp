//
//  ExploreViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var exploreSearchBar: UISearchBar!
    @IBOutlet weak var categoryProductCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchFakeContainView: UIView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var searchFakeView: UIView!
    
    var exploreViewModel = ExploreViewModel()
    private var cartViewModel = CartViewModel()
    private let utilities = Utilities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        showFilterScreen()
    }
    
    func setupView() {
        categoryProductCollectionView.delegate = self
        categoryProductCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        exploreSearchBar.delegate = self
        exploreViewModel.delegate = self
        cartViewModel.delegate = self
        
        searchView.isHidden = true
        actionTappedSearchFake()
        
        categoryProductCollectionView.register(cellType: ExploreCollectionViewCell.self)
        productCollectionView.register(cellType: ItemCollectionViewCell.self)
        exploreViewModel.loadItemCategory()
        
        searchFakeView.clipsToBounds = true
        searchFakeView.layer.cornerRadius = 15
    }
    
    func showFilterScreen() {
        let mainStoryboard = UIStoryboard(name: "Filter", bundle: .main)
        guard let filterViewController = mainStoryboard.instantiateViewController(withIdentifier: "FilterView") as? FilterViewController else { return }
        filterViewController.modalPresentationStyle = .fullScreen
        filterViewController.filterViewModel.arrayProduct = exploreViewModel.arrayProduct
        filterViewController.delegate = self
        present(filterViewController, animated: true, completion: nil)
    }
    
    private func actionTappedSearchFake() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        searchFakeContainView.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        searchView.isHidden = false
        searchFakeContainView.isHidden = true
        categoryProductCollectionView.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    func cancelSearch() {
        searchView.isHidden = true
        searchFakeContainView.isHidden = false
        categoryProductCollectionView.isHidden = false
        navigationController?.isNavigationBarHidden = false
    }
    
    func navigationTypeProductView() {
        let mainStoryboard = UIStoryboard(name: "TypeProduct", bundle: .main)
        guard let typeProductViewController = mainStoryboard.instantiateViewController(withIdentifier: "TypeProductView") as? TypeProductViewController else { return }
        typeProductViewController.nameCategory = exploreViewModel.nameCategory
        typeProductViewController.typeProductViewModel.arrayProduct = exploreViewModel.arrayProduct
        typeProductViewController.modalPresentationStyle = .fullScreen
        present(typeProductViewController, animated: true, completion: nil)
    }
}

extension ExploreViewController: UICollectionViewDelegate {}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryProductCollectionView {
            return exploreViewModel.arrayImageCategory.count
        } else {
            if !exploreViewModel.arrayProductFilter.isEmpty {
                return exploreViewModel.arrayProductFilter.count
            } else {
                return exploreViewModel.arrayProduct.count
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryProductCollectionView {
            let itemCell = collectionView.dequeueReusableCell(with: ExploreCollectionViewCell.self, for: indexPath)
            let image = exploreViewModel.arrayImageCategory[indexPath.item]
            let name = exploreViewModel.arrayNameCategory[indexPath.item]
            let color = exploreViewModel.arrayColorBackground[indexPath.item]
            itemCell.configure(name: name, image: image, color: color)
            return itemCell
        } else {
            let itemProductCell = collectionView.dequeueReusableCell(with: ItemCollectionViewCell.self, for: indexPath)
            if !exploreViewModel.arrayProductFilter.isEmpty {
                itemProductCell.configure(item: exploreViewModel.arrayProductFilter[indexPath.item])
            } else {
                itemProductCell.configure(item: exploreViewModel.arrayProduct[indexPath.item])
            }
            itemProductCell.delegate = self
            return itemProductCell
        }
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryProductCollectionView {
            return CGSize(width: (collectionView.frame.width - 45) / 2, height: collectionView.frame.height / 3.3)
        } else {
            return CGSize(width: (collectionView.frame.width - 45) / 2, height: collectionView.frame.height / 3.3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryProductCollectionView {
            return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        } else {
            return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryProductCollectionView {
            exploreViewModel.getProductByCategory(categoryId: exploreViewModel.arrayIdCategory[indexPath.row], categoryName: exploreViewModel.arrayNameCategory[indexPath.row])
        } else {
            let mainStoryboard = UIStoryboard(name: "Detail", bundle: .main)
            guard let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else { return }
            detailViewController.modalPresentationStyle = .fullScreen
            detailViewController.detailViewModel.itemProduct = exploreViewModel.arrayProduct[indexPath.item]
            present(detailViewController, animated: true, completion: nil)
        }
    }
}

extension ExploreViewController: ExploreViewModelEvents {
    func gotError(messageError: String) {
        DispatchQueue.main.async {
            self.showAlert(message: messageError)
        }
    }
    
    func gotFilter() {
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    
    func gotData(isSearch: Bool) {
        DispatchQueue.main.async {
            if isSearch {
                self.categoryProductCollectionView.reloadData()
                self.productCollectionView.reloadData()
            } else {
                self.navigationTypeProductView()
            }
        }
    }
    
    func gotMessage(message: String) {
        DispatchQueue.main.async {
            self.showAlert(message: message)
        }
    }
}
extension ExploreViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        exploreViewModel.arrayProduct = []
        productCollectionView.reloadData()
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            productCollectionView.reloadData()
            searchBar.resignFirstResponder()
            searchBar.text = ""
            showAlert(message: "Please enter the keyword you want to search.")
            exploreViewModel.arrayProduct = []
            return
        }
        exploreViewModel.searchProductByName(productName: query)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.showsCancelButton = false
        cancelSearch()
    }
}

extension ExploreViewController: ItemCollectionViewCellEvents {
    func addCart(idProduct: String) {
        DispatchQueue.main.async {
            self.cartViewModel.filterProductCart(productId: idProduct, amount: "1", isCart: false, userId: self.utilities.getUserId())
        }
    }
}

extension ExploreViewController: CartViewModelEvents {
    func gotDataCart(messageChangeData: String) {
        DispatchQueue.main.async {
            if !messageChangeData.isEmpty {
                self.showAlert(message: messageChangeData)
            }
        }
    }
    
    func gotAmountProduct(amount: String) {}
    
    func gotIdOrder() {}
    
    func gotErrorCart(messageError: String) {
        DispatchQueue.main.async {
            self.showAlert(message: messageError)
        }
    }
}

extension ExploreViewController: FilterViewDelegate {
    func gotFilter(filterViewModel: FilterViewModel) {
        DispatchQueue.main.async {
            self.exploreViewModel.filterDone(model: filterViewModel)
        }
    }
}
