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
        return exploreViewModel.arrayImageCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(with: ExploreCollectionViewCell.self, for: indexPath)
        let image = exploreViewModel.arrayImageCategory[indexPath.item]
        let name = exploreViewModel.arrayNameCategory[indexPath.item]
        let color = exploreViewModel.arrayColorBackground[indexPath.item]
        itemCell.configure(name: name, image: image, color: color)
        return itemCell
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 45) / 2, height: collectionView.frame.height / 3.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "TypeProduct", bundle: .main)
        guard let typeProductViewController = mainStoryboard.instantiateViewController(withIdentifier: "TypeProductView") as? TypeProductViewController else { return }
        typeProductViewController.nameCategory = exploreViewModel.arrayNameCategory[indexPath.row]
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
