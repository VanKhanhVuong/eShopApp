//
//  CustomView.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 20/05/2021.
//

import UIKit

class CustomView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override init (frame: CGRect){
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        //contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
