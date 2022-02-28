//
//  MoviesModel.swift
//  TMDBTeste
//
//  Created by Lucas Gomesx on 23/02/22.
//

import Foundation

struct MoviesModel: Codable {
    let page: Int
    let results: [Result]
    let total_pages: Int
    let total_results: Int
}

struct Result: Codable {
    let originalTitle, overview: String
    let posterPath: String?
    let title: String
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
