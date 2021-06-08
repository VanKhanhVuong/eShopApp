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
    
    private var exploreViewModel = ExploreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        categoryProductCollectionView.delegate = self
        categoryProductCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        exploreSearchBar.delegate = self
        exploreViewModel.delegate = self
        
        searchView.isHidden = true
        actionTappedSearchFake()
        
        categoryProductCollectionView.register(cellType: ExploreCollectionViewCell.self)
        productCollectionView.register(cellType: ItemCollectionViewCell.self)
        exploreViewModel.loadItemCategory()
        
        searchFakeView.clipsToBounds = true
        searchFakeView.layer.cornerRadius = 15
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
}

extension ExploreViewController: UICollectionViewDelegate {
}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryProductCollectionView {
            return exploreViewModel.arrayImageCategory.count
        } else {
            return exploreViewModel.arrayProductByName.count
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
            itemProductCell.configure(item: exploreViewModel.arrayProductByName[indexPath.item])
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
            let mainStoryboard = UIStoryboard(name: "TypeProduct", bundle: .main)
            guard let typeProductViewController = mainStoryboard.instantiateViewController(withIdentifier: "TypeProductView") as? TypeProductViewController else { return }
            typeProductViewController.nameCategory = exploreViewModel.arrayNameCategory[indexPath.row]
            typeProductViewController.modalPresentationStyle = .fullScreen
            present(typeProductViewController, animated: true, completion: nil)
        } else {
            let mainStoryboard = UIStoryboard(name: "Detail", bundle: .main)
            guard let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else { return }
            detailViewController.modalPresentationStyle = .fullScreen
            detailViewController.detailViewModel.itemProduct = exploreViewModel.arrayProductByName[indexPath.item]
            present(detailViewController, animated: true, completion: nil)
        }
    }
}

extension ExploreViewController: ExploreViewModelEvents {
    func gotMessage(message: String) {
        showAlert(message: message)
    }
    
    func gotData() {
        DispatchQueue.main.async {
            self.categoryProductCollectionView.reloadData()
            self.productCollectionView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        showAlert(message: messageError.rawValue)
    }
}
extension ExploreViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        exploreViewModel.arrayProductByName = []
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
            exploreViewModel.arrayProductByName = []
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
