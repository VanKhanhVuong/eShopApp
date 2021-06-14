//
//  OrderSuccessViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 26/05/2021.
//

import UIKit

protocol OrderSuccessViewDelegate: AnyObject {
    func backToCart()
}

class OrderSuccessViewController: UIViewController {
    @IBOutlet weak var backToCartButton: UIButton!
    
    weak var delegate: OrderSuccessViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func backToCart() {
        self.dismiss(animated: true, completion: nil)
        delegate?.backToCart()
    }
    
    func setupView() {
        backToCartButton.configureButton()
    }
    
    @IBAction func backToHomeTapped(_ sender: Any) {
        backToCart()
    }
}
