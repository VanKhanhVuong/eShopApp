//
//  TypeProductViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

class TypeProductViewController: UIViewController {
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    var typeProductViewModel = TypeProductModel()
    private var cartViewModel = CartViewModel()
    var nameCategory: String = ""
    private let utilities = Utilities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        titleNavigationItem.title = nameCategory
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        typeProductViewModel.delegate = self
        cartViewModel.delegate = self
        
        productCollectionView.register(cellType: ItemCollectionViewCell.self)
        typeProductViewModel.loadItemProduct()
    }
    
    func showFilterScreen() {
        let mainStoryboard = UIStoryboard(name: "Filter", bundle: .main)
        guard let filterViewController = mainStoryboard.instantiateViewController(withIdentifier: "FilterView") as? FilterViewController else { return }
        filterViewController.modalPresentationStyle = .fullScreen
        filterViewController.filterViewModel.arrayProduct = typeProductViewModel.arrayProduct
        filterViewController.delegate = self
        present(filterViewController, animated: true, completion: nil)
    }
}

extension TypeProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Detail", bundle: .main)
        guard let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else { return }
        detailViewController.modalPresentationStyle = .fullScreen
        detailViewController.detailViewModel.itemProduct = typeProductViewModel.arrayProduct[indexPath.item]
        present(detailViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func backExploreTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        showFilterScreen()
    }
}

extension TypeProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !typeProductViewModel.arrayProductFilter.isEmpty {
            return typeProductViewModel.arrayProductFilter.count
        } else {
            return typeProductViewModel.arrayProduct.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(with: ItemCollectionViewCell.self, for: indexPath)
        if !typeProductViewModel.arrayProductFilter.isEmpty {
            let image = typeProductViewModel.arrayProductFilter[indexPath.row]
            itemCell.configure(item: image)
        } else {
            let image = typeProductViewModel.arrayProduct[indexPath.row]
            itemCell.configure(item: image)
        }
        itemCell.delegate = self
        return itemCell
    }
}

extension TypeProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 45) / 2, height: collectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
}

extension TypeProductViewController: TypeProductModelEvents {
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
    
    func gotData() {
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
}

extension TypeProductViewController: ItemCollectionViewCellEvents {
    func addCart(idProduct: String) {
        DispatchQueue.main.async {
            self.cartViewModel.filterProductCart(productId: idProduct, amount: "1", isCart: false, userId: self.utilities.getUserId())
        }
    }
}

extension TypeProductViewController: CartViewModelEvents {
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

extension TypeProductViewController: FilterViewDelegate {
    func gotFilter(filterViewModel: FilterViewModel) {
        DispatchQueue.main.async {
            self.typeProductViewModel.filterDone(model: filterViewModel)
        }
    }
}
