//
//  SearchCard.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 07.06.24.
//

import SwiftUI

struct SearchCard: View {
    // MARK: - Properties
    
    let movie: Movie
    
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // MARK: - Image Loading
            HStack {
                AsyncImage(url: movie.posterPath?.toURL()) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 95, height: 120)
                .cornerRadius(16)
                
                // MARK: - Movie Details
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(movie.title)")
                        .font(.system(size: 16))
                        .padding(.bottom, 14)
                    
                    HStack {
                        Image("star")
                        Text("\(movie.formattedVoteAverage)")
                    }
                    
                    HStack {
                        Image("calendar")
                        Text("\(movie.formattedYear)")
                    }
                    
                    HStack {
                        Image("clock")
                        Text("\(movie.voteCount ?? 0)")
                    }
                    
                    HStack {
                        Image("ticket")
                        Text("\(movie.originalLanguage)")
                    }
                }.font(.system(size: 12))
                
                Spacer()
            }
        }.frame(width: 307, height: 120)
    }
}
