//
//  SignUpViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 19/05/2021.
//

import UIKit

@available(iOS 13.0, *)
class SignInViewController: UIViewController {
    @IBOutlet weak var phoneNumberView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        actionClickShowDetail()
    }
    
    func actionClickShowDetail() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.phoneNumberView.addGestureRecognizer(gesture)
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        let storyBoard = UIStoryboard(name: "Number", bundle: nil)
        guard let numberView = storyBoard.instantiateViewController(identifier: "NumberView") as? NumberViewController else { return }
        self.navigationController?.pushViewController(numberView, animated: true)
    }
}
