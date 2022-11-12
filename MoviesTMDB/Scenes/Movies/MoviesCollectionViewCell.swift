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

    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private var movieDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 12)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    private var movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewConfigure()
        configureConstraints()
    }

    private func viewConfigure(){
        contentView.addSubview(movieImage)
        contentView.addSubview(movieDescription)
        contentView.addSubview(movieTitle)
    }

    private func configureConstraints(){
        movieImageConstraints()
        movieDescriptionConstraints()
        movieTitleConstraints()
    }

    private func movieImageConstraints() {
        movieImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    private func movieDescriptionConstraints() {
        movieDescription.snp.makeConstraints { make in
            make.top.equalTo(128)
            make.right.equalTo(-16)
            make.left.equalTo(16)
            make.bottom.equalTo(-16)
        }
    }

    private func movieTitleConstraints() {
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.width.equalTo(ScreenSize.width)
            make.height.equalTo(24)
            make.right.equalTo(-16)
            make.left.equalTo(16)
        }
    }

    public func set(_ movies: Movie) {
        guard let posterPath = movies.posterPath else {
            return
        }
        guard let imageUrl = URL(string: "\(Constant.NetworkConstans.MovieServiceEndPoint.getImage())\(posterPath)") else {
            return
        }
        DispatchQueue.main.async {
            self.movieImage.kf.setImage(with: imageUrl)
            self.movieTitle.text = "\(String(describing: movies.title ?? "")) (\(Helper.shared.dateFormat(movies.releaseDate, format: "yyyy")))"
            self.movieDescription.text = movies.overview
        }
    }

    @available(*, unavailable)
      public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
      }
}

