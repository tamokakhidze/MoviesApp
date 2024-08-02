//
//  FavoritesView.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 08.06.24.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject var viewModel = FavouritesViewModel()
    
    var gridColumns: [GridItem] {
        let screenWidth = UIScreen.main.bounds.width
        
        if screenWidth >= 768 {
            return Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200), spacing: 100, alignment: .center), count: 2)

        } else {
            return [
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .center)
            ]
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground.ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: gridColumns) {
                        ForEach(viewModel.favoritesArray) { favoriteMovie in
                            NavigationLink(
                                destination: MovieDetailView(movieId: favoriteMovie.id)
                            ) {
                                SearchCard(movie: favoriteMovie)
                            }.foregroundStyle(.primaryText)
                        }
                    }
                }.padding()
                
            }.onAppear() {
                viewModel.loadFavorites()
            }
            .navigationTitle("Favourites")
        }
    }
}

#Preview {
    ContentView()
}
