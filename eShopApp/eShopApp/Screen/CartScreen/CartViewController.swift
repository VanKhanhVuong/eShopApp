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
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var cartViewModel = CartViewModel()
    var cartTableViewCell = CartTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartViewModel.findCart()
    }
    
    func setupUIView() {
        carTableView.delegate = self
        carTableView.dataSource = self
        cartViewModel.delegate = self
        cartTableViewCell.delegate = self
        carTableView.allowsSelection = false
        carTableView.register(cellType: CartTableViewCell.self)
        
        checkoutButton.clipsToBounds = true
        checkoutButton.layer.cornerRadius = 15
    }
}

extension CartViewController: UITableViewDelegate {
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.arrayCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(with: CartTableViewCell.self, for: indexPath)
        let image = cartViewModel.arrayCart[indexPath.row]
        itemCell.configure(item: image)
        itemCell.delegate = self
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension CartViewController: CartViewModelEvents {
    func gotData(option: EnumApiCart) {
        DispatchQueue.main.async {
            self.carTableView.reloadData()
            self.totalPriceLabel.text = "$" + "\(self.cartViewModel.totalPrice())"
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}

extension CartViewController: CartTableViewCellEvents {
    func clickToRemoveProductFromCart(idCart: String) {
        DispatchQueue.main.async {
            self.cartViewModel.findCart()
            self.cartViewModel.deleteCart(idCart: idCart)
        }
    }
    
    func clickPlusOrMinusButton(amount: String, cell: CartTableViewCell ) {
        self.cartViewModel.addOrUpdateAmountProductToCart(productId: cell.productId, cartId: cell.cartId, amount: amount)
        DispatchQueue.main.async {
            self.totalPriceLabel.text = "$" + "\(self.cartViewModel.totalPrice())"
            self.cartViewModel.findCart()
        }
    }
}
