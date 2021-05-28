//
//  FavoritesViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var addAllButton: UIButton!
    
    var favoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoritesViewModel.delegate = self
        
        favoriteTableView.register(cellType: FavoritesTableViewCell.self)

        favoritesViewModel.loadItemProduct()
        
        addAllButton.clipsToBounds = true
        addAllButton.layer.cornerRadius = 15
    }
}

extension FavoritesViewController: UITableViewDelegate {
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.arrayProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(with: FavoritesTableViewCell.self, for: indexPath)
        let image = favoritesViewModel.arrayProduct[indexPath.row]
        itemCell.configure(item: image)
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension FavoritesViewController: FavoritesViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}
