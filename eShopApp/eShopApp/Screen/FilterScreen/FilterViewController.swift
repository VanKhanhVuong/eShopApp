//
//  FilterViewController.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 24/05/2021.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func gotFilter(filterViewModel:FilterViewModel)
}

class FilterViewController: UIViewController {
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var closeFilterButton: UIBarButtonItem!
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    
    var filterViewModel = FilterViewModel()
    private var exploreViewController = ExploreViewController()
    private var arrayCategory: [String] = []
    private var arrayBrand: [String] = []
    weak var delegate: FilterViewDelegate?
    
    private var arrayName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUIView()
    }
    
    @IBAction func closeFilterTapped(_ sender: Any) {
        closeFilter()
    }
    
    @IBAction func applyFilterTapped(_ sender: Any) {
        filterViewModel.getData(array: arrayName)
    }
    
    func setupView() {
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterViewModel.delegate = self
        
        filterViewModel.loadData()
        
        filterTableView.isEditing = true
        filterTableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func closeFilter() {
        exploreViewController.exploreViewModel.arrayFilter = filterViewModel.arrayProductFilter
        delegate?.gotFilter(filterViewModel: filterViewModel)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUIView() {
        applyFilterButton.clipsToBounds = true
        applyFilterButton.layer.cornerRadius = 15
    }
    
    func showCategory(str: String, index: Int) -> String {
        if str == "Category" {
            return filterViewModel.arrayCategory[index].categoryId ?? ""
        } else {
            return filterViewModel.arrayBrand[index].brandId ?? ""
        }
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(showCategory(str: filterViewModel.headerTitles[indexPath.section], index: indexPath.row))")
        self.arrayName.append(showCategory(str: filterViewModel.headerTitles[indexPath.section], index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("delete \(showCategory(str: filterViewModel.headerTitles[indexPath.section], index: indexPath.row))")
        let string = showCategory(str: filterViewModel.headerTitles[indexPath.section], index: indexPath.row)
        let arr = arrayName.filter { $0 != string}
        arrayName = arr
        print(arrayName)
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
    func gotFilter() {
        DispatchQueue.main.async {
            self.closeFilter()
        }
    }
    
    func gotData(isCategoryData: Bool) {
        DispatchQueue.main.async {
            self.filterTableView.reloadData()
        }
    }
    
    func gotError(messageError: ErrorModel) {
        print("")
    }
}
