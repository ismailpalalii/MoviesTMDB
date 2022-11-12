//
//  MoviesViewModel.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import Foundation

final class MoviesViewModel {

    // MARK: - Property
    private let service: ServiceProtocol
    
    // MARK: - Initialization
    init(service: ServiceProtocol) {
        self.service = service
    }
}
