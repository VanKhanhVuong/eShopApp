//
//  MainViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 27/05/2021.
//

import UIKit

class MainViewController: UITabBarController {
    @IBOutlet weak var menuTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        menuTabBar.clipsToBounds = true
        menuTabBar.layer.cornerRadius = 20
        menuTabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        menuTabBar.layer.shadowRadius = 5
        menuTabBar.layer.shadowOffset = CGSize(width: 5, height: 5)
        menuTabBar.layer.shadowOpacity = 0.7
        menuTabBar.layer.shadowColor = UIColor.black.cgColor
    }
}
