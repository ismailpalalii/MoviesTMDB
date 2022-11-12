//
//  MoviesDetailViewModel.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import Foundation

protocol MoviesDetailViewModelOutput: class {
    func displayProductDetail(_ movie: MovieDetailModel)
}

final class MoviesDetailViewModel {

    private var datasource:MovieDetailModel?

    weak var output: MoviesDetailViewModelOutput?
    private let service: ServiceProtocol

    // MARK: - Initialization
    init(service: ServiceProtocol) {
        self.service = service
    }
}

// MARK: Events
extension MoviesDetailViewModel {
    func getProductDetail(
        _ movieID: Int
    ) {
        service.fetchMovieDetail(movieID: movieID) { response in
            guard let response = response else {return}
            self.datasource = response
            print(response)
            DispatchQueue.main.async {
                self.output?.displayProductDetail(response)
                }
            }
        }
    }
