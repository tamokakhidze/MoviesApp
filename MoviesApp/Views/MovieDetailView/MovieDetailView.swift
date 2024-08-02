//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 07.06.24.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    let movieId: Int
    
    var body: some View {
        VStack {
            if let movie = viewModel.movie {
                BackdropImageView(url: movie.backdropPath?.toURL())
                
                MovieHeaderView(movie: movie)
                    .offset(y: -60)
                    .padding(.horizontal, 29)
                
                MovieInfoView(movie: movie)
                    .padding(.horizontal, 29)
                
                MovieDescriptionView(overview: movie.overview)
                    .padding(.horizontal, 29)
                    .environmentObject(viewModel)
                
                Spacer()
            } else {
                ProgressView()
            }
        }
        
        .onAppear {
            viewModel.viewAppeared(movieId: movieId)
        }
    }
}

// MARK: - BackdropImageView
struct BackdropImageView: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .clipped()
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: 210)
        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
    }
}

// MARK: - MovieHeaderView
struct MovieHeaderView: View {
    let movie: DetailedMovie
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
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
            
            Text(movie.title)
                .font(.system(size: 18))
                .fontWeight(.heavy)
            
            Spacer()
        }
    }
}

// MARK: - MovieInfoView
struct MovieInfoView: View {
    let movie: DetailedMovie
    
    var body: some View {
        HStack(spacing: 12) {
            MovieInfoItemView(imageName: "calendar", text: movie.formattedYear)
            
            Divider()
                .frame(width: 1, height: 16)
                .background(Color.gray)
            
            MovieInfoItemView(imageName: "clock", text: "\(movie.runtime)")
            
            Divider()
                .frame(width: 1, height: 16)
                .background(Color.gray)
            
            MovieInfoItemView(imageName: "ticket", text: movie.genres[0].name)
        }
    }
}

struct MovieInfoItemView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(imageName)
                .renderingMode(.template)
                .foregroundColor(.gray)
            
            Text(text)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - MovieDescriptionView
struct MovieDescriptionView: View {
    let overview: String
    @EnvironmentObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 14) {
                HStack() {
                    Text("About the movie")
                    Spacer()
                    // MARK: - Favourite button
                    Button(action: {
                        viewModel.toggleHeartIcon()
                    }, label: {
                        Image(systemName: viewModel.changeHeartIcon())
                            .foregroundColor(viewModel.isMovieFavorited ? .red : .gray)
                    })
                    
                }
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            
            ScrollView {
                Text(overview)
            }
        }
    }
}

#Preview {
    ContentView()
}
