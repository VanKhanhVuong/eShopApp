//
//  HomeViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 17/05/2021.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet weak var slidePageControl: UIPageControl!
    @IBOutlet weak var topicTableView: UITableView!
    
    var homeViewModel = HomeViewModel()
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        slideCollectionView.delegate = self
        slideCollectionView.dataSource = self
        //topicTableView.delegate = self
        topicTableView.dataSource = self
        
        slideCollectionView.register(cellType: SlideCollectionViewCell.self)
        topicTableView.register(cellType: TopicTableViewCell.self)
        topicTableView.register(CustomSectionHeader.nib, forHeaderFooterViewReuseIdentifier:CustomSectionHeader.className)
        
        slidePageControl.numberOfPages = homeViewModel.arrayPoster.count
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / slideCollectionView.frame.size.width)
        slidePageControl.currentPage = currentIndex
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.arrayPoster.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SlideCollectionViewCell.self, for: indexPath)
        let poster = homeViewModel.arrayPoster[indexPath.item]
        cell.configure(urlString: poster)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TopicTableViewCell.self, for: indexPath)
        return cell
    }
}

//extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
//}



