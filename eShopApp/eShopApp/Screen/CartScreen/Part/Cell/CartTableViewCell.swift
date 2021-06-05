//
//  CartTableViewCell.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import UIKit

protocol CartTableViewCellEvents: AnyObject {
    func clickPlusOrMinusButton(amount: String, cell: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var amountItemLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var deleteItemButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: CartTableViewCellEvents?
    var productId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(item: Cart) {
        productId = item.productId ?? ""
        itemImageView.getImage(urlString: item.imageProduct ?? "")
        nameLabel.text = item.productName
//        unitLabel.text = item.unit
        guard let price: Double = Double(item.price ?? "") else { return }
        guard let amount: Double = Double(item.amount ?? "") else { return }
        let total = price * amount
        priceLabel.text = "$" + "\(total)"
        let amountProduct = Int(amount)
        amountItemLabel.text = "\(amountProduct)"
        if amountItemLabel.text == "1" {
            minusButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    func setupUI() {
        minusButton.layer.borderWidth = 0.5
        minusButton.layer.borderColor = UIColor.gray.cgColor
        minusButton.clipsToBounds = true
        minusButton.layer.cornerRadius = 15
        
        plusButton.layer.borderWidth = 0.5
        plusButton.layer.borderColor = UIColor.gray.cgColor
        plusButton.clipsToBounds = true
        plusButton.layer.cornerRadius = 15
    }
    
    @IBAction func plusTouchButton(_ sender: Any) {
        if minusButton.titleColor(for: .normal) == .gray {
            minusButton.setTitleColor(.systemGreen, for: .normal)
        }
        let amount: Int = Int(amountItemLabel.text ?? "") ?? 0
        amountItemLabel.text = "\(amount + 1)"
        let str: String = priceLabel.text ?? ""
        let int: Double = Double(str.dropFirst()) ?? 0.0
        priceLabel.text = "$\((Double(amount + 1)) * round(int))"
        delegate?.clickPlusOrMinusButton(amount: amountItemLabel.text ?? "", cell: self)
    }
    
    @IBAction func minusTouchButton(_ sender: Any) {
        let amount: Int = Int(amountItemLabel.text ?? "") ?? 0
        if amount <= 1 {
            amountItemLabel.text = "1"
            minusButton.setTitleColor(.gray, for: .normal)
        } else {
            let str: String = priceLabel.text ?? ""
            let int: Double = Double(str.dropFirst()) ?? 0.0
            amountItemLabel.text = "\(amount - 1)"
            if amountItemLabel.text == "1" {
                minusButton.setTitleColor(.gray, for: .normal)
            }
            priceLabel.text = "$\(round(int / (Double(amount))))"
        }
        delegate?.clickPlusOrMinusButton(amount: amountItemLabel.text ?? "", cell: self)
    }
}
