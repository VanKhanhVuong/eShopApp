//
//  CategoryView.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 21/05/2021.
//

import UIKit

class CategoryView: UIView {
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    override init (frame: CGRect){
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    func commitInit() {
        Bundle.main.loadNibNamed(className.self, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
