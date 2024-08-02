//
//  StringExtension.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 07.06.24.
//

import Foundation

extension String {
    func toURL() -> URL {
        URL(string: "https://image.tmdb.org/t/p/w500/\(self)")!
    }
}
