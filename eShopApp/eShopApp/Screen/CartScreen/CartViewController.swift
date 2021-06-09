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
        cartViewModel.findCart(userId: getUserId())
    }
    
    @IBAction func checkoutTapped(_ sender: Any) {
//        let vc = CheckoutViewController()
//        vc.modalPresentationStyle = .custom
//        present(vc, animated: true, completion: nil)
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
    func gotErrorCart(messageError: String) {
        DispatchQueue.main.async {
            self.showAlert(message: messageError)
        }
    }
    
    func gotAmountProduct(amount: String) {
        print("Get amount product in cart.")
    }
    
    func gotDataCart(messageChangeData: String) {
        DispatchQueue.main.async {
            if !messageChangeData.isEmpty {
                self.showAlert(message: messageChangeData)
            }
            self.carTableView.reloadData()
            self.totalPriceLabel.text = "$" + "\(self.cartViewModel.totalPrice())"
        }
    }
}

extension CartViewController: CartTableViewCellEvents {
    func clickToRemoveProductFromCart(idCart: String) {
        DispatchQueue.main.async {
            self.cartViewModel.deleteCart(idCart: idCart, userId: self.getUserId())
        }
    }
    
    func clickPlusOrMinusButton(amount: String, cell: CartTableViewCell ) {
        if amount == "1" {
            self.cartViewModel.deleteCart(idCart: cell.cartId, userId: getUserId())
        } else {
            DispatchQueue.main.async {
                self.cartViewModel.filterProductCart(productId: cell.productId, amount: amount, isCart: true, userId: self.getUserId())
            }
        }
    }
}
