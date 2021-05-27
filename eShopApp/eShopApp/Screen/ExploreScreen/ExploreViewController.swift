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
    
    private var exploreViewModel = ExploreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.title = "Find Product"
        categoryProductCollectionView.delegate = self
        categoryProductCollectionView.dataSource = self
        exploreViewModel.delegate = self
        
        categoryProductCollectionView.register(cellType: ExploreCollectionViewCell.self)
        exploreViewModel.loadItemCategory()
    }
}

extension ExploreViewController: UICollectionViewDelegate {
}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreViewModel.arrayCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(with: ExploreCollectionViewCell.self, for: indexPath)
        let image = exploreViewModel.arrayCategory[indexPath.row]
        itemCell.configure(item: image)
        return itemCell
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 45) / 2, height: collectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "TypeProduct", bundle: .main)
        guard let typeProductViewController = mainStoryboard.instantiateViewController(withIdentifier: "TypeProductView") as? TypeProductViewController else { return }
        guard let nameCategory = exploreViewModel.arrayCategory[indexPath.row].categoryName else { return }
        typeProductViewController.nameCategory = nameCategory
        typeProductViewController.modalPresentationStyle = .fullScreen
        present(typeProductViewController, animated: true, completion: nil)
    }
}

extension ExploreViewController: ExploreViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            self.categoryProductCollectionView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}
