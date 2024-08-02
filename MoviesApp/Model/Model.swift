//
//  Model.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 04.06.24.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double?
    let voteCount: Int?
    let genreIds: [Int]?
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
    }

    var formattedVoteAverage: String {
        if let voteAverage = voteAverage {
            return String(format: "%.1f", voteAverage)
        }
        return "No vote"
    }
    
    var formattedYear: String {
        return String(releaseDate.prefix(4))
    }
}

