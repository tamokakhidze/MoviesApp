//
//  ContentView.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 04.06.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MoviesListView()
                .tabItem {
                    VStack {
                        Image(.home)
                            .renderingMode(.template)
                        Text("Movies")
                    }
                }
            
            SearchView()
                .tabItem {
                    VStack {
                        Image(.search)
                            .renderingMode(.template)
                        Text("Search")
                    }
                }
            
            FavouritesView()
                .tabItem {
                    VStack {
                        Image(.saved)
                            .renderingMode(.template)
                        Text("Favourites")
                    }
                }
        }
        .accentColor(.blue)
        
    }
}
