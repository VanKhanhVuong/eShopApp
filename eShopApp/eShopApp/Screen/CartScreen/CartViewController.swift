//
//  CartViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import UIKit
import KeychainAccess

class CartViewController: UIViewController {
    @IBOutlet weak var carTableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var cartViewModel = AddCartViewModel()
    var cartTableViewCell = CartTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let keychain = Keychain()
        let token = keychain["token"] ?? ""
        cartViewModel.findCart(userId: token)
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
    
    func totalPrice() {
        var sum = 0.0
        for item in cartViewModel.arrayCart {
            guard let price: Double = Double(item.price ?? "") else { return }
            guard let amount: Double = Double(item.amount ?? "") else { return }
            sum += price * amount
        }
        totalPriceLabel.text = "$" + "\(sum)"
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

extension CartViewController: AddCartViewModelEvents {
    func gotData(option: EnumApiCart) {
        if option == .showCart {
            DispatchQueue.main.async {
                self.carTableView.reloadData()
                self.totalPrice()
            }
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}

extension CartViewController: CartTableViewCellEvents {
    func clickPlusOrMinusButton() {
        DispatchQueue.main.async {
            self.totalPrice()
        }
    }
}
