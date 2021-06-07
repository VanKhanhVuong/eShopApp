//
//  FavoritesViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import Foundation
import KeychainAccess

protocol FavoritesViewModelEvents: AnyObject {
    func gotDataFavorite(messageChangeData: String)
    func gotFavoriteProduct(isFavorite: Bool, idFavorite: String)
    func gotErrorFavorite(messageError: ErrorModel)
}

class FavoritesViewModel {
    private var api = APIClient()
    var arrayFavorite: [Favorite] = []
    var keychain = Keychain()
    
    weak var delegate: FavoritesViewModelEvents?
    
    // Show all favorite products
    func loadItemFavorite() {
        arrayFavorite = []
        let userId = keychain["token"] ?? ""
        api.findFavoriteToAPI(userId: userId){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (favorite) in
                        self.arrayFavorite.append(favorite)
                    }
                    self.delegate?.gotDataFavorite(messageChangeData: "")
                }
            case .failure(let error):
                self.delegate?.gotErrorFavorite(messageError: error)
                break
            }
        }
    }
    
    // Add products to favorites
    func addProductInFavorite(productId: String) {
        let userId = keychain["token"] ?? ""
        api.addFavoriteToAPI(productId: productId, userId: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.loadItemFavorite()
                self.delegate?.gotDataFavorite(messageChangeData: "Favorite")
            case .failure(let error):
                self.delegate?.gotErrorFavorite(messageError: error)
                break
            }
        }
    }
    
    // Delete products to favorites
    func deleteProductInFavorite(idFavorite: String) {
        api.deleteFavoriteToAPI(id: idFavorite) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.loadItemFavorite()
                self.delegate?.gotDataFavorite(messageChangeData: "Un favorite")
            case .failure(let error):
                self.delegate?.gotErrorFavorite(messageError: error)
                break
            }
        }
    }
    
    // Check if the product is liked or not
    func checkProductInFavorite(productId: String) {
        let userId = keychain["token"] ?? ""
        api.checkFavoriteToAPI(productId: productId, userId: userId) { [weak self] result in
            var array: [Favorite] = []
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if !result.isEmpty {
                    result.forEach { (favorite) in
                        array.append(favorite)
                    }
                    if array.count != 0 {
                        self.delegate?.gotFavoriteProduct(isFavorite: true, idFavorite: array.first?.id ?? "")
                    }
                } else {
                    self.delegate?.gotFavoriteProduct(isFavorite: false, idFavorite: "")
                }
            case .failure(let error):
                self.delegate?.gotErrorFavorite(messageError: error)
                break
            }
        }
    }
}
