//
//  UICollectionViewCell+Extension.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 13.11.2022.
//

import UIKit
import SnapKit

extension MoviesCollectionViewCell {

     func viewConfigure(){
        contentView.addSubview(movieImageCollectionView)
        contentView.addSubview(movieDescriptionCollectionView)
        contentView.addSubview(movieTitleCollectionView)
    }

     func setupUICollectionView(){

         movieDescriptionCollectionView.font = UIFont(name: "SFProText-Semibold", size: 12)
         movieDescriptionCollectionView.textColor = .white
         movieDescriptionCollectionView.numberOfLines = 2

         movieTitleCollectionView.font = UIFont(name: "SFProDisplay-Bold", size: 20)
         movieTitleCollectionView.textColor = .white
         movieTitleCollectionView.numberOfLines = 0
         
         movieImageCollectionView.snp.makeConstraints { make in
             make.top.left.right.bottom.equalToSuperview()
         }
         movieDescriptionCollectionView.snp.makeConstraints { make in
             make.top.equalTo(128)
             make.right.equalTo(-16)
             make.left.equalTo(16)
             make.bottom.equalTo(-16)
         }
         movieTitleCollectionView.snp.makeConstraints { make in
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
            self.movieImageCollectionView.kf.setImage(with: imageUrl)
            self.movieTitleCollectionView.text = "\(String(describing: movies.title ?? "")) (\(Helper.shared.dateFormat(movies.releaseDate, format: "yyyy")))"
            self.movieDescriptionCollectionView.text = movies.overview
        }
    }
}
