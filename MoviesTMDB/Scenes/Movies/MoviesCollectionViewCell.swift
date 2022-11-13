//
//  MoviesCollectionViewCell.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit

final class MoviesCollectionViewCell: UICollectionViewCell {

    enum Identifier: String {
        case path = "CollectionViewCell"
    }

    lazy var movieImageCollectionView = UIImageView.customImageView()
    lazy var movieDescriptionCollectionView = UILabel.customLabel()
    lazy var movieTitleCollectionView = UILabel.customLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewConfigure()
        setupUICollectionView()
    }
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
}
