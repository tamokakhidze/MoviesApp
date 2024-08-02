//
//  MovieCard.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 05.06.24.
//

import SwiftUI

struct MovieCard: View {
    
    // MARK: - Properties
    let movie: Movie
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Image Loading
            VStack(spacing: 10) {
                AsyncImage(url: movie.posterPath?.toURL()) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 146)
                .cornerRadius(16)
                
                // MARK: - Title
                Text("\(movie.title)")
                    .font(.system(size: 12))
                    .foregroundStyle(.primaryText)
                    .frame(width: 100, height: 36)
                
                Spacer()
            }
        }
        .frame(width: 100, height: 192)
        .cornerRadius(16)
    }
}

#Preview {
    ContentView()
}
