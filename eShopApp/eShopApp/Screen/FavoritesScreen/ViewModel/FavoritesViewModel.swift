//
//  FavoritesViewModel.swift
//  eShopApp
//
//  Created by Văn Khánh Vương on 25/05/2021.
//

import Foundation

protocol FavoritesViewModelEvents: AnyObject {
    func gotDataFavorite(messageChangeData: String)
    func gotFavoriteProduct(isFavorite: Bool, idFavorite: String)
    func gotErrorFavorite(messageError: String)
}

class FavoritesViewModel {
    private var api = APIClient()
    var arrayFavorite: [Favorite] = []
    weak var delegate: FavoritesViewModelEvents?
    
    // Show all favorite products
    func loadItemFavorite(userId: String) {
        arrayFavorite.removeAll()
        if !userId.isEmpty {
            api.findFavoriteToAPI(userId: userId){ [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let favorites):
                    if !favorites.isEmpty {
                        self.arrayFavorite = favorites
                        self.delegate?.gotDataFavorite(messageChangeData: "")
                    }
                case .failure(let error):
                    self.delegate?.gotErrorFavorite(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorFavorite(messageError: "Please Login")
        }
    }
    
    // Add products to favorites
    func addProductInFavorite(productId: String, userId: String) {
        api.addFavoriteToAPI(productId: productId, userId: userId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.loadItemFavorite(userId: userId)
                self.delegate?.gotDataFavorite(messageChangeData: "Favorite")
            case .failure(let error):
                self.delegate?.gotErrorFavorite(messageError: error.rawValue)
                break
            }
        }
    }
    
    // Delete products to favorites
    func deleteProductInFavorite(idFavorite: String, userId: String) {
        api.deleteFavoriteToAPI(id: idFavorite) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.loadItemFavorite(userId: userId)
                self.delegate?.gotDataFavorite(messageChangeData: "Un favorite")
            case .failure(let error):
                self.delegate?.gotErrorFavorite(messageError: error.rawValue)
                break
            }
        }
    }
    
    // Check if the product is liked or not
    func checkProductInFavorite(productId: String, userId: String) {
        arrayFavorite.removeAll()
        if !userId.isEmpty {
            api.checkFavoriteToAPI(productId: productId, userId: userId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let favorites):
                    if !favorites.isEmpty {
                        self.delegate?.gotFavoriteProduct(isFavorite: true, idFavorite: favorites.first?.id ?? "")
                    } else {
                        self.delegate?.gotFavoriteProduct(isFavorite: false, idFavorite: "")
                    }
                case .failure(let error):
                    self.delegate?.gotErrorFavorite(messageError: error.rawValue)
                    break
                }
            }
        } else {
            delegate?.gotErrorFavorite(messageError: "Please Login")
        }

    }
}
