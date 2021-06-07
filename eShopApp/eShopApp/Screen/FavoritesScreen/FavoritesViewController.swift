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
    var cartViewModel = CartViewModel()
    private var amount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesViewModel.loadItemFavorite()
    }
    
    @IBAction func addAllToCartTapped(_ sender: Any) {
        addAllToCart()
    }
    
    func setUpView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoritesViewModel.delegate = self
        cartViewModel.delegate = self
        
        favoriteTableView.register(cellType: FavoritesTableViewCell.self)

        addAllButton.clipsToBounds = true
        addAllButton.layer.cornerRadius = 15
    }
    
    func addAllToCart() {
        if !favoritesViewModel.arrayFavorite.isEmpty {
            favoritesViewModel.arrayFavorite.forEach { (favorite) in
                print(favorite.id ?? "")
                amount = amount + 1
                cartViewModel.filterProductCart(productId: favorite.productId ?? "", amount: "\(amount)", isCart: true)
            }
        } else {
            print("Favorite empty")
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let mainStoryboard = UIStoryboard(name: "Detail", bundle: .main)
//        if #available(iOS 13.0, *) {
//            guard let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController else { return }
//            detailViewController.modalPresentationStyle = .fullScreen
//            detailViewController.detailViewModel.itemProduct = favoritesViewModel.arrayFavorite[indexPath.item]
//            present(detailViewController, animated: true, completion: nil)
//        } else {
//            // Fallback on earlier versions
//        }
//    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.arrayFavorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(with: FavoritesTableViewCell.self, for: indexPath)
        let favorite = favoritesViewModel.arrayFavorite[indexPath.row]
        itemCell.configure(item: favorite)
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension FavoritesViewController: FavoritesViewModelEvents {
    func gotFavoriteProduct(isFavorite: Bool, idFavorite: String) {
        print("")
    }
    
    func gotDataFavorite(messageChangeData: String) {
        DispatchQueue.main.async {
            if !messageChangeData.isEmpty {
                self.showAlert(message: messageChangeData)
            }
            self.favoriteTableView.reloadData()
        }
    }
    
    func gotErrorFavorite(messageError: ErrorModel) {
        print("")
    }
}

extension FavoritesViewController: CartViewModelEvents {
    func gotDataCart(messageChangeData: String) {
        DispatchQueue.main.async {
            self.showAlert(message: messageChangeData)
        }
    }
    
    func gotAmountProduct(amount: String) {
        print("")
    }
    
    func gotErrorCart(messageError: ErrorModel) {
        print(messageError.rawValue)
    }
}
