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
    @IBOutlet weak var slidePageControl: UIPageControl!
    
    private var priceProduct: Float = 0
    private var currentIndex: Int = 0
    private var arrayImageProduct: [String] = []
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func touchPlusButton(_ sender: Any) {
        if minusButton.titleColor(for: .normal) == .gray {
            minusButton.setTitleColor(.systemGreen, for: .normal)
        }
        let amount: Int = Int(amountNumberLabel.text ?? "") ?? 0
        amountNumberLabel.text = "\(amount + 1)"
        totalLabel.text = "$\((Float(amount + 1)) * priceProduct)"
    }
    
    @IBAction func touchMinusButton(_ sender: Any) {
        let amount: Int = Int(amountNumberLabel.text ?? "") ?? 0
        if amount == 1 {
            amountNumberLabel.text = "1"
            minusButton.setTitleColor(.gray, for: .normal)
        } else {
            amountNumberLabel.text = "\(amount - 1)"
            totalLabel.text = "$\((Float(amount - 1)) * priceProduct)"
        }
    }
    
    private func setupView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        detailViewModel.delegate = self
        
        detailViewModel.getData()
        detailViewModel.loadItemImageProduct()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        likeLabel.addGestureRecognizer(tap)
        
        imageCollectionView.register(cellType: ImageProductCollectionViewCell.self)
        minusButton.setTitleColor(.gray, for: .normal)
        descriptionLabel.isHidden = true
        actionClickShowDetail()
        addToCartButton.clipsToBounds = true
        addToCartButton.layer.cornerRadius = 15
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let nameProduct: String = nameProductLabel.text else { return }
        if likeLabel.text == "❤️" {
            print("Unlike " + nameProduct)
            likeLabel.text = "🤍"
        } else {
            print("Like " + nameProduct)
            likeLabel.text = "❤️"
        }
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

@available(iOS 13.0, *)
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailViewModel.arrayImageProduct.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(with: ImageProductCollectionViewCell.self, for: indexPath)
        let image = detailViewModel.arrayImageProduct[indexPath.row]
        imageCell.configure(imageProduct: image)
        return imageCell
    }
}

@available(iOS 13.0, *)
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

@available(iOS 13.0, *)
extension DetailViewController: DetailViewModelEvents {
    func gotData(isData: Bool) {
        if isData {
            DispatchQueue.main.async {
                self.nameProductLabel.text = self.detailViewModel.productName
                self.descriptionLabel.text = self.detailViewModel.productDetail
                self.totalLabel.text = "$\(self.detailViewModel.productPrice)"
                self.priceProduct = self.detailViewModel.productPrice
                self.starLabel.attributedText = self.changeColorText(number: self.detailViewModel.productRate, color: .orange)
            }
        } else {
            DispatchQueue.main.async {
                self.imageCollectionView.reloadData()
            }
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}

@available(iOS 13.0, *)
extension DetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(imageCollectionView), scrollView.isDragging {
            currentIndex = Int((scrollView.contentOffset.x) / imageCollectionView.frame.size.width)
            slidePageControl.currentPage = currentIndex
        } else {
            // When Scrolling other CollectionViews slideCollectionView.
        }
    }
}
