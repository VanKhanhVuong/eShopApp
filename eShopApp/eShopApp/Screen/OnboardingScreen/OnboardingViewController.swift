//
//  OnboardingViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 17/05/2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var getStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        getStartButton.clipsToBounds = true
        getStartButton.layer.cornerRadius = 15
    }
    
    @IBAction func getStartedTapped(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        guard let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainView") as? MainViewController else { return }
        homeViewController.modalPresentationStyle = .fullScreen
        present(homeViewController, animated: true, completion: nil)
    }
}
