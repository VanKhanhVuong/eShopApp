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
    var nameCategory: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        titleNavigationItem.title = nameCategory
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        typeProductViewModel.delegate = self
        
        productCollectionView.register(cellType: ItemCollectionViewCell.self)
        typeProductViewModel.loadItemProduct()
    }
    @IBAction func backExploreTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        showFilterScreen()
    }
    
    func showFilterScreen() {
        let mainStoryboard = UIStoryboard(name: "Filter", bundle: .main)
        guard let filterViewController = mainStoryboard.instantiateViewController(withIdentifier: "FilterView") as? FilterViewController else { return }
        filterViewController.modalPresentationStyle = .fullScreen
        present(filterViewController, animated: true, completion: nil)
    }
}

extension TypeProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if #available(iOS 13.0, *) {
                let mainStoryboard = UIStoryboard(name: "Detail", bundle: .main)
                guard let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else { return }
                detailViewController.modalPresentationStyle = .fullScreen
                detailViewController.detailViewModel.itemProduct = typeProductViewModel.arrayProduct[indexPath.item]
                present(detailViewController, animated: true, completion: nil)
            }
    }
}

extension TypeProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeProductViewModel.arrayProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(with: ItemCollectionViewCell.self, for: indexPath)
        let image = typeProductViewModel.arrayProduct[indexPath.row]
        itemCell.configure(item: image)
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
    func gotData() {
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}
