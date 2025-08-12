//
//  FavoritesViewModel.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoriteCity] = []
    
    func addFavorite(city: String) {
        if !favorites.contains(where: { $0.cityName == city }) {
            favorites.append(FavoriteCity(cityName: city))
        }
    }
    
    func removeFavorite(city: String) {
        favorites.removeAll { $0.cityName == city }
    }
}
