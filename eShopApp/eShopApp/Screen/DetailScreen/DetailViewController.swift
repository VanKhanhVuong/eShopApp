//
//  DetailViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 18/05/2021.
//

import UIKit

@available(iOS 13.0, *)
class DetailViewController: UIViewController {
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var showDescriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dropImageView: UIImageView!
    @IBOutlet weak var unitProductLabel: UILabel!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var amountNumberLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private var priceProduct: Float = 0
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        detailViewModel.delegate = self
        detailViewModel.getData()
    }
    
    @IBAction func touchPlusButton(_ sender: Any) {
        if minusButton.titleColor(for: .normal) == .gray {
            minusButton.setTitleColor(.systemGreen, for: .normal)
        }
        let amount: Int = Int(amountNumberLabel.text ?? "") ?? 0
        amountNumberLabel.text = "\(amount + 1)"
        totalLabel.text = "\((amount + 1) * 1000)"
    }
    
    @IBAction func touchMinusButton(_ sender: Any) {
        let amount: Int = Int(amountNumberLabel.text ?? "") ?? 0
        if amount == 1 {
            amountNumberLabel.text = "1"
            minusButton.setTitleColor(.gray, for: .normal)
        } else {
            amountNumberLabel.text = "\(amount - 1)"
            totalLabel.text = "\((amount - 1) * 1000)"
        }
    }
    
    private func setupView() {
        imageCollectionView.delegate = self
        //imageCollectionView.dataSource = self
        minusButton.setTitleColor(.gray, for: .normal)
        descriptionLabel.isHidden = true
        actionClickShowDetail()
        addToCartButton.clipsToBounds = true
        addToCartButton.layer.cornerRadius = 15
    }
    
    private func changeColorText(number: Int, color: UIColor) -> NSMutableAttributedString{
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "★★★★★" as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: CGFloat(18.0)) as Any])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location:0, length: number))
        return myMutableString
    }
    
    private func actionClickShowDetail() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.showDescriptionView.addGestureRecognizer(gesture)
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        if descriptionLabel.isHidden {
            animate(toogle: true)
        } else {
            animate(toogle: false)
        }
    }
    
    private func animate(toogle: Bool) {
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.descriptionLabel.isHidden = false
                self.dropImageView.image = UIImage(systemName:"chevron.down")
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.descriptionLabel.isHidden = true
                self.dropImageView.image = UIImage(systemName:"greaterthan")
            }
        }
    }
}

//@available(iOS 13.0, *)
//extension DetailViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//}

@available(iOS 13.0, *)
extension DetailViewController: UICollectionViewDelegateFlowLayout {
}

@available(iOS 13.0, *)
extension DetailViewController: DetailViewModelEvents {
    func gotData() {
        DispatchQueue.main.async {
            self.nameProductLabel.text = self.detailViewModel.productName
            self.descriptionLabel.text = self.detailViewModel.productDetail
            self.totalLabel.text = "$\(self.detailViewModel.productPrice)"
            self.priceProduct = self.detailViewModel.productPrice
            self.starLabel.attributedText = self.changeColorText(number: self.detailViewModel.productRate, color: .orange)
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}
