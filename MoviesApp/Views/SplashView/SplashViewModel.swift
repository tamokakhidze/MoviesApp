//
//  SplashViewModel.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 07.06.24.
//

import Foundation
import NetworkServicePackage

class SplashViewModel: ObservableObject {
    // MARK: - Properties
    private let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=936d7807b77bbb4238f8847775a026ad"
    @Published var isDataLoaded = false
    
    // MARK: - Fetching Data
    
    func viewAppeared() {
        fetchData() { [weak self] result in
            switch result {
            case .success(let success):
                self?.cacheGenres(result: success.genres)
                self?.isDataLoaded = true
            case .failure(let failure):
                print("fetching failed. \(failure)")
            }
        }
    }
    
    func fetchData(completion: @escaping (Result<Genres,Error>) ->(Void)){
        NetworkService().getData(urlString: url, completion: completion)
            
    }
    
    // MARK: - Caching genres
    func cacheGenres(result: [Genre]) {
        for genre in result {
            UserDefaults.standard.setValue(genre.id, forKey: genre.name)
        }
    }

}

