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
        let mainStoryboard = UIStoryboard(name: "Number", bundle: .main)
        guard let numberViewController = mainStoryboard.instantiateViewController(withIdentifier: "NumberView") as? NumberViewController else { return }
        numberViewController.modalPresentationStyle = .fullScreen
        present(numberViewController, animated: true, completion: nil)
    }
}
