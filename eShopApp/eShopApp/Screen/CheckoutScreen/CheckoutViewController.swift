//
//  CheckoutViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 09/06/2021.
//

import UIKit

final class CheckoutViewController: UIViewController {
    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    let menuView = CheckoutPopUp()
    let menuHeight = UIScreen.main.bounds.height / 1.8
    var isPresenting = false
    var checkoutViewModel = CheckoutViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tapCartScreen()
        checkoutViewModel.delegate = self
    }
    
    func setupUI() {
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(menuView)
        
        menuView.delegate = self
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: menuHeight).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func tapCartScreen() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismissCheckoutView()
    }
    
    private func dismissCheckoutView() {
        dismiss(animated: true, completion: nil)
    }
    
    func navigationOrderSusscess() {
        let mainStoryboard = UIStoryboard(name: "OrderSuccess", bundle: .main)
        guard let signUpViewController = mainStoryboard.instantiateViewController(withIdentifier: "OrderSuccessView") as? OrderSuccessViewController else { return }
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
    }
}

extension CheckoutViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            menuView.frame.origin.y += menuHeight
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}

extension CheckoutViewController: CheckoutPopUpDelegate {
    func closeCheckoutView() {
        DispatchQueue.main.async {
            self.dismissCheckoutView()
        }
    }
    func submit() {
        DispatchQueue.main.async {
            self.checkoutViewModel.createOrder(idUser: self.getUserId())
        }
    }
}
extension CheckoutViewController: CheckoutViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            self.navigationOrderSusscess()
        }
    }
    
    func gotError(messageError: String) {
        DispatchQueue.main.async {
            self.showAlert(message: messageError)
        }
    }
}
