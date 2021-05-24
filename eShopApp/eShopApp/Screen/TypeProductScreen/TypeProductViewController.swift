//
//  TypeProductViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 23/05/2021.
//

import UIKit

class TypeProductViewController: UIViewController {
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    private var typeProductViewModel = TypeProductModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        typeProductViewModel.delegate = self
        
        productCollectionView.register(cellType: TestCollectionViewCell.self)
        typeProductViewModel.loadItemProduct()
    }
}

extension TypeProductViewController: UICollectionViewDelegate {
    
}

extension TypeProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeProductViewModel.arrayProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(with: TestCollectionViewCell.self, for: indexPath)
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
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
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
