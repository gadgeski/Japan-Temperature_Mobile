//
//  FavoritesView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.favorites) { favorite in
                Text(favorite.cityName)
            }
            Button("東京をお気に入りに追加") {
                viewModel.addFavorite(city: "Tokyo")
            }
        }
    }
}
