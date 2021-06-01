//
//  CategoryView.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 21/05/2021.
//

import UIKit
protocol CategoryViewEvents: AnyObject {
    func gotData(title: String)
}

class CategoryView: UIView {
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    weak var delegate: CategoryViewEvents?
    
    @IBAction func touchSeeAllProduct(_ sender: Any) {
        delegate?.gotData(title: categoryTitleLabel.text ?? "")
    }
    
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
