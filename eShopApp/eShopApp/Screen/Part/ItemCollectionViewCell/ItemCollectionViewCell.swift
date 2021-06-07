//
//  ItemCollectionViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 18/05/2021.
//

import UIKit
protocol ItemCollectionViewCellEvents: AnyObject {
    func addCart(item: ItemCollectionViewCell)
}

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameItemLabel: UILabel!
    @IBOutlet weak var unitItemLabel: UILabel!
    @IBOutlet weak var priceItemLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var buyButton: UIButton!
    
    var idProduct: String = ""
    weak var delegate: ItemCollectionViewCellEvents?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.gray.cgColor
        
        buyButton.clipsToBounds = true
        buyButton.layer.cornerRadius = 15
    }
    
    func configure(item: Product) {
        itemImageView.getImage(urlString: item.imageProduct ?? "")
        nameItemLabel.text = item.productName
        idProduct = item.productId ?? ""
        guard let price = item.price else { return }
        priceItemLabel.text = "$" + price
    }
    
    @IBAction func touchBuyButton(_ sender: Any) {
        delegate?.addCart(item: self)
    }
}
