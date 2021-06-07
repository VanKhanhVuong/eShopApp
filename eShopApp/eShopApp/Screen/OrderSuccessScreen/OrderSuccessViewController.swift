//
//  OrderSuccessViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 26/05/2021.
//

import UIKit

class OrderSuccessViewController: UIViewController {
    @IBOutlet weak var trackOrderButton: UIButton!
    @IBOutlet weak var backToHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        trackOrderButton.clipsToBounds = true
        trackOrderButton.layer.cornerRadius = 15
        
        trackOrderButton.clipsToBounds = true
        trackOrderButton.layer.cornerRadius = 15
    }
}
