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
    private let utilities = Utilities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartViewModel.findCart(userId: utilities.getUserId())
    }

    func setupUIView() {
        carTableView.delegate = self
        carTableView.dataSource = self
        cartViewModel.delegate = self
        cartTableViewCell.delegate = self
        carTableView.allowsSelection = false
        carTableView.register(cellType: CartTableViewCell.self)
        
        checkoutButton.configureButton()
    }
    
    func createOrder() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let idOrder = utilities.getUserId() + "\(hour)\(minutes)\(month)\(year)"
        cartViewModel.updateOrderIdToCart(idOrder: idOrder, userId: utilities.getUserId())
    }
    
    func navigationCheckout() {
        let checkoutViewController = CheckoutViewController()
        checkoutViewController.checkoutViewModel.idOrder = cartViewModel.idOrder
        checkoutViewController.checkoutViewModel.totalBill = "\(cartViewModel.totalPrice())"
        checkoutViewController.modalPresentationStyle = .custom
        checkoutViewController.delegate = self
        present(checkoutViewController, animated: true, completion: nil)
    }
    
    @IBAction func checkoutTapped(_ sender: Any) {
        if cartViewModel.totalPrice() != 0.0 {
            createOrder()
        } else {
            showAlert(message: "Sorry cart empty")
        }
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
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

}

extension CartViewController: CartViewModelEvents {
    func gotIdOrder() {
        DispatchQueue.main.async {
            self.navigationCheckout()
        }
    }
    
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
            if self.cartViewModel.arrayCart.isEmpty {
                self.carTableView.reloadData()
                self.totalPriceLabel.text = "$" + "0.0"
            } else {
                self.carTableView.reloadData()
                self.totalPriceLabel.text = "$" + "\(self.cartViewModel.totalPrice())"
            }
            if !messageChangeData.isEmpty {
                self.showAlert(message: messageChangeData)
            }
        }
    }
}

extension CartViewController: CartTableViewCellEvents {
    func clickToRemoveProductFromCart(idCart: String) {
        DispatchQueue.main.async {
            self.cartViewModel.deleteCart(idCart: idCart, userId: self.utilities.getUserId())
        }
    }
    
    func clickPlusOrMinusButton(amount: String, cell: CartTableViewCell ) {
        DispatchQueue.main.async {
            self.cartViewModel.filterProductCart(productId: cell.productId, amount: amount, isCart: true, userId: self.utilities.getUserId())
        }
    }
}

extension CartViewController: CheckoutViewDelegate {
    func backToCart() {
        DispatchQueue.main.async {
            self.cartViewModel.findCart(userId: self.utilities.getUserId())
        }
    }
}
