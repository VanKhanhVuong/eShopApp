//
//  CheckoutPopUp.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 04/06/2021.
//

import UIKit

protocol CheckoutPopUpDelegate: AnyObject {
    func closeCheckoutView()
    func submit()
}

class CheckoutPopUp: UIView {
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var totalBillLabel: UILabel!
    
    weak var delegate: CheckoutPopUpDelegate?
    
    override init (frame: CGRect){
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        placeOrderButton.configureButton()
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("CheckoutPopUp", owner: self, options: nil)
        addSubview(contentView)
        setupUI()
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    @IBAction func closeCheckout(_ sender: Any) {
        delegate?.closeCheckoutView()
    }
    
    @IBAction func placeOrderTapped(_ sender: Any) {
        delegate?.submit()
    }
}
