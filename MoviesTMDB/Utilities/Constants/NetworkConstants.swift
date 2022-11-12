//
//  NetworkConstants.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import Foundation

extension Constant {
    class NetworkConstans {
        enum MovieServiceEndPoint: String {
            case BASEURL = "https://api.themoviedb.org/3/movie/"
            case APIKEY =  "5446b5c19e9238c6aac08e1b5a23c57a"
            case LANG = "&language=en-US"
            case IMAGEPATH = "https://image.tmdb.org/t/p/w500"
            case upcoming = "upcoming"
            case nowplaying = "now_playing"

            static func fetchUpComingMovies() -> String {
                "\(BASEURL.rawValue)\(upcoming.rawValue)?api_key=\(APIKEY.rawValue)\(LANG.rawValue)"
            }

            static func fetchNowPlayingMovies() -> String {
                "\(BASEURL.rawValue)\(nowplaying.rawValue)?api_key=\(APIKEY.rawValue)\(LANG.rawValue)"
            }

            static func fetchDetailMovie(movieID: Int) -> String {
                "\(BASEURL.rawValue)/\(movieID)?api_key=\(APIKEY.rawValue)\(LANG.rawValue)"
            }

            static func getImage() -> String {
                "\(IMAGEPATH)"
            }
        }
    }
}
