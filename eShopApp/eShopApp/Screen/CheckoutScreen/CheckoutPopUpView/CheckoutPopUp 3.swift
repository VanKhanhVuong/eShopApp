//
//  CheckoutPopUp.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 04/06/2021.
//

import UIKit

class CheckoutPopUp: UIView {
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    override init (frame: CGRect){
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        commitInit()
    }
    
    private func commitInit() {
        self.backgroundColor = .gray
        self.frame = UIScreen.main.bounds
        Bundle.main.loadNibNamed("CheckoutPopUp", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
