//
//  MoviesListView.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 04.06.24.
//

import SwiftUI

// MARK: - MoviesListView
struct MoviesListView: View {
    
    // MARK: - Properties
    @StateObject var viewModel = MoviesListViewViewModel()
    
    var gridColumns: [GridItem] {
        let screenWidth = UIScreen.main.bounds.width
        
        if screenWidth >= 768 {
            return Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .center), count: 4)
        } else {
            return Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .center), count: 3)
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground.ignoresSafeArea()
                VStack {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: gridColumns, spacing: 20) {
                            ForEach(viewModel.moviesArray, id: \.id) { movie in
                                NavigationLink(value: movie.id) {
                                    MovieCard(movie: movie)
                                }
                            }
                        }
                        .onAppear {
                            viewModel.viewAppeared()
                        }
                    }
                    .navigationTitle("Movies")
                    .navigationDestination(for: Int.self) { movieId in
                        MovieDetailView(movieId: movieId)
                    }
                }.padding(27)
            }
        }
    }
}

