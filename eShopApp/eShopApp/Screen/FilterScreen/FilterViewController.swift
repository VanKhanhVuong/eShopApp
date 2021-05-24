//
//  FilterViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var closeFilterButton: UIBarButtonItem!
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    
    private var filterViewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUIView()
    }
    
    func setupView() {
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterViewModel.delegate = self
        filterViewModel.loadData()
        filterTableView.isEditing = true
        filterTableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func setupUIView() {
        applyFilterButton.clipsToBounds = true
        applyFilterButton.layer.cornerRadius = 15
    }
    
    func test(str: String, index: Int) -> String {
        if str == "Category" {
            return filterViewModel.arrayCategory[index].categoryName ?? ""
        } else {
            return filterViewModel.arrayBrand[index ].brandName ?? ""
        }
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(test(str: filterViewModel.headerTitles[indexPath.section], index: indexPath.row))")
    }
}

extension FilterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterViewModel.headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < filterViewModel.headerTitles.count {
            return filterViewModel.headerTitles[section]
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterViewModel.headerTitles[section] == "Category" {
            return filterViewModel.arrayCategory.count
        } else {
            return filterViewModel.arrayBrand.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.tintColor = .systemGreen
        if filterViewModel.headerTitles[indexPath.section] == "Category" {
            cell.textLabel?.text = filterViewModel.arrayCategory[indexPath.row].categoryName
        } else {
            cell.textLabel?.text = filterViewModel.arrayBrand[indexPath.row].brandName
        }
        return cell
    }
}

extension FilterViewController: FilterViewModelEvents {
    func gotData(isCategoryData: Bool) {
        DispatchQueue.main.async {
            self.filterTableView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}
