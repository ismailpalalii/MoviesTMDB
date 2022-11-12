//
//  MoviesViewModel.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import Foundation

import Foundation

protocol MoviesViewModelOutput: AnyObject {
    func reloadList()
    func showProductDetail(_ movie: MovieDetailModel)
}

final class MoviesViewModel {

    private(set) var datasourceUpcoming: [Movie] = []
    private(set) var datasourceNowplaying: [Movie] = []

    weak var output: MoviesViewModelOutput?
    private let service: ServiceProtocol

    // MARK: - Initialization
    init(service: ServiceProtocol) {
        self.service = service
    }
}

// MARK: Events
extension MoviesViewModel {
    func getNowPlayingList() {
        service.fetchNowPlayingMovies { [weak self] response in
            guard let response = response else {return}
            self?.datasourceNowplaying = response
            print(response)
            DispatchQueue.main.async {
                self?.output?.reloadList()
            }
        }
    }

    func getUpcomingList() {
        service.fetchUpcomingMovies { [weak self] response in
            guard let response = response else {return}
            self?.datasourceUpcoming = response
            print(response)
            DispatchQueue.main.async {
                self?.output?.reloadList()
            }
        }
    }

    /// Select an item with IndexPath
    /// - Parameter indexPath: IndexPath of selected item
    func didSelectItemAt(
        _ indexPath: IndexPath, movieID: Int
    ) {
//        let product = datasource[indexPath.row]
//        output?.showProductDetail(product)
    }
}
