//
//  Services.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import Foundation
import Alamofire

// MARK: - Services Protocol
protocol ServiceProtocol {
    func fetchUpcomingMovies(completion: @escaping ([Movie]?) -> Void)
    func fetchNowPlayingMovies(completion: @escaping ([Movie]?) -> Void)
    func fetchMovieDetail(movieID:Int,completion: @escaping (MovieDetailModel?) -> Void)
}

// MARK: - Services
final class Services: ServiceProtocol {
    func fetchMovieDetail(movieID:Int,completion: @escaping (MovieDetailModel?) -> Void) {
        AF.request(Constant.NetworkConstans.MovieServiceEndPoint.fetchDetailMovie(movieID: movieID)).responseDecodable(of: MovieDetailModel.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data.self)
        }
    }

    func fetchNowPlayingMovies(completion: @escaping ([Movie]?) -> Void) {
        AF.request(Constant.NetworkConstans.MovieServiceEndPoint.fetchNowPlayingMovies()).responseDecodable(of: MoviesResponse.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data.movies)
        }
    }

    func fetchUpcomingMovies(completion: @escaping ([Movie]?) -> Void) {
        AF.request(Constant.NetworkConstans.MovieServiceEndPoint.fetchUpComingMovies()).responseDecodable(of: MoviesResponse.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data.movies)
        }
    }
}
