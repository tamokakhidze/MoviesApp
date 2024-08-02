//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 05.06.24.
//

import Foundation
import Combine
import NetworkServicePackage

enum Filter: String, CaseIterable, Identifiable {
    case Name, Genre, Year
    var id: Self { self }
}

class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var resultArray = [Movie]()
    @Published var text = ""
    @Published var filterCase = Filter.Name
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $text
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.getResults()
            }
            .store(in: &cancellables)
    } //vidzaxebt demonebs radgan race conditioni iyo (swrafad ro vwerdi)
    
    private func getResults() {
        resultArray = []
        let url = getUrl()
        if text != ""{
            viewAppeared(url: url)
            
        }
    }
    
    func onSwitchFilter() {
        resultArray = []
        text = ""
    }
    
    func getUrl() -> String {
        switch filterCase {
        case .Name:
            return "https://api.themoviedb.org/3/search/movie?query=\(text)&api_key=936d7807b77bbb4238f8847775a026ad"
        case .Genre:
            let genreId = getIdByName(name: text) ?? -1
            return "https://api.themoviedb.org/3/discover/movie?api_key=936d7807b77bbb4238f8847775a026ad&with_genres=\(genreId)"
        case .Year:
            return "https://api.themoviedb.org/3/discover/movie?api_key=936d7807b77bbb4238f8847775a026ad&primary_release_year=\(text)"
        }
    }
    
    func viewAppeared(url: String) {
        fetchData(url: url) { [weak self] result in
            switch result {
            case .success(let success):
                if self!.filterCase == .Year {
                    self?.resultArray = success.results.filter { movie in
                        movie.releaseDate.prefix(4) == self!.text
                    }
                }
                else {
                    self?.resultArray = success.results
                }
            case .failure(let failure):
                print("fetching failed. \(failure)")
            }
        }
    }
    
    func getIdByName(name: String) -> Int? {
        return UserDefaults.standard.integer(forKey: name)
    }
    
    func fetchData(url: String, completion: @escaping (Result<MovieResponse,Error>) ->(Void)){
        NetworkService().getData(urlString: url, completion: completion)
    }
    
}


