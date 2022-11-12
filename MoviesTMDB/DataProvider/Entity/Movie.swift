//
//  Movie.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int
    enum CodingKeys: String, CodingKey {
        case page, movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - MovieDetailModel
struct MovieDetailModel: Codable {

    let adult: Bool
    let backdropPath: String
    let budget: Int
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case budget, homepage, id
        case imdbID
        case originalLanguage
        case originalTitle
        case overview, popularity
        case posterPath
        case releaseDate
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage
        case voteCount
    }
}
