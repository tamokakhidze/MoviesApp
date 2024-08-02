//
//  FavoritesViewModel.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 08.06.24.
//

import Foundation

class FavouritesViewModel: ObservableObject {
    @Published var favoritesArray = [Movie]()
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: "favoritesArray"),
           let decodedData = try? JSONDecoder().decode([Movie].self, from: savedData) {
            favoritesArray = decodedData
        }
    }
}
