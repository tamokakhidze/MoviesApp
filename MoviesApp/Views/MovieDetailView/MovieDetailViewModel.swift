//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 07.06.24.
//
import Foundation
import NetworkServicePackage

class MovieDetailViewModel: ObservableObject {
    // MARK: - Properties
    @Published var movie: DetailedMovie?
    @Published var isMovieFavorited: Bool = false
    var favoritesArray = [Movie]() {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        loadFavorites()
    }
    
    // MARK: - Fetching Data
    func viewAppeared(movieId: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=936d7807b77bbb4238f8847775a026ad"
        fetchData(url: url) { [weak self] result in
            switch result {
            case .success(let success):
                self?.movie = success
                self?.checkIfMovieIsFavorited()
            case .failure(let failure):
                print("fetching failed. \(failure)")
            }
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<DetailedMovie,Error>) ->(Void)){
        NetworkService().getData(urlString: url, completion: completion)
    }
    
    // MARK: - Marking movie as favorite
    func changeHeartIcon() -> String {
        return isMovieFavorited ? "heart.fill" : "heart"
    }
    
    func toggleHeartIcon() {
        isMovieFavorited.toggle()
        addMovieToFavorites()
    }
    
    func addMovieToFavorites() {
        guard let myMovie = movie else { return }
        if isMovieFavorited {
            if !favoritesArray.contains(where: { $0.id == myMovie.id }) {
                favoritesArray.append(myMovie.toSimpleMovie())
                
            }
        } else {
            favoritesArray.removeAll(where: { $0.id == myMovie.id })
        }
    }
    
    func checkIfMovieIsFavorited() {
        guard let myMovie = movie else { return }
        isMovieFavorited = favoritesArray.contains(where: { $0.id == myMovie.id })
    }
    
    func saveFavorites() {
        if let encodedData = try? JSONEncoder().encode(favoritesArray) {
            UserDefaults.standard.set(encodedData, forKey: "favoritesArray")
        }
    }
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: "favoritesArray"),
           let decodedData = try? JSONDecoder().decode([Movie].self, from: savedData) {
            favoritesArray = decodedData
        }
    }
}
// ეს ექსთენშენი მჭირდება რომ სერჩის ქარდი გამოვიყენო ფავორიტების გვერდზეც რომელიც რეალურად დეტალურ მუვის იღებს<3
extension DetailedMovie {
    func toSimpleMovie() -> Movie {
        return Movie(
            id: self.id,
            title: self.title,
            overview: self.overview,
            backdropPath: self.backdropPath,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            voteAverage: self.voteAverage,
            voteCount: self.voteCount,
            genreIds: self.genres.map { genre in
                genre.id
            },
            originalLanguage: self.originalLanguage
        )
    }
}
