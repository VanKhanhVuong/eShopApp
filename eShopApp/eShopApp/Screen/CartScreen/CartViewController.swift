//
//  CartViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var carTableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    var cartViewModel = CartViewModel()
    var cartTableViewCell = CartTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
    }
    
    func setupUIView() {
        carTableView.delegate = self
        carTableView.dataSource = self
        cartViewModel.delegate = self
        cartTableViewCell.delegate = self
        carTableView.allowsSelection = false
        
        cartViewModel.loadItemProduct()
        carTableView.register(cellType: CartTableViewCell.self)
        
        checkoutButton.clipsToBounds = true
        checkoutButton.layer.cornerRadius = 15
    }
}

extension CartViewController: UITableViewDelegate {
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.arrayProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(with: CartTableViewCell.self, for: indexPath)
        let image = cartViewModel.arrayProduct[indexPath.row]
        itemCell.configure(item: image)
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension CartViewController: CartViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            self.carTableView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}

extension CartViewController: CartTableViewCellEvents {
    func plusOrMinusButton(item: CartTableViewCell, calculation: Bool) {
    }
}
