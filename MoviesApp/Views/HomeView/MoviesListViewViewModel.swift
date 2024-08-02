//
//  MoviesListViewViewModel.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 04.06.24.
//

import Foundation
import NetworkServicePackage

class MoviesListViewViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var moviesArray = [Movie]()
    private let url = "https://api.themoviedb.org/3/movie/popular?api_key=936d7807b77bbb4238f8847775a026ad"
    
    // MARK: - Fetching Data
    
    func viewAppeared() {
        fetchData() { [weak self] result in
            switch result {
            case .success(let success):
                self?.moviesArray = success.results
            case .failure(let failure):
                print("fetching failed. \(failure)")
            }
        }
    }
    
    func fetchData(completion: @escaping (Result<MovieResponse,Error>) ->(Void)){
        NetworkService().getData(urlString: url, completion: completion)
    }
    
}
