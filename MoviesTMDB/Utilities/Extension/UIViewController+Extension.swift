//
//  UIViewController+Extension.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit
import SnapKit

extension MoviesViewController {

    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(tableView)
        contentView.addSubview(pageController)
        contentView.addSubview(activityIndicator)
        view.backgroundColor = .white
    }

    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setupUI() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self.view)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.32)
        }
        pageController.snp.makeConstraints { make in
            //make.top.equalToSuperview().offset(216)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.55)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(pageController.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.68)
        }
    }

    func configureRefreshControl () {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(handleRefreshControl),
                                             for: .valueChanged)
    }
}

extension MovieDetailViewController {

    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
        contentView.addSubview(imdbButton)
        contentView.addSubview(rateImageView)
        contentView.addSubview(movieDate)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieDescLabel)
        contentView.addSubview(movieRate)
        contentView.backgroundColor = .white
        scrollView.backgroundColor = .white
    }

    func setupUI(){
        movieDate.font = UIFont(name: "SFProText-Semibold", size: 13)
        movieDate.textColor = .black
        movieTitleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        movieTitleLabel.textColor = .black
        movieTitleLabel.numberOfLines = 0
        movieDescLabel.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        movieDescLabel.textColor = .black
        movieDescLabel.numberOfLines = 0
        movieRate.font = UIFont(name: "SFProDisplay-Bold", size: 13)
        movieRate.textColor = .black
        movieRate.numberOfLines = 0
        imdbButton.setImage(UIImage(named: "imdb"), for: .normal)
        imdbButton.addTarget(self, action: #selector(websiteButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self.view)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
        }

        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalTo(0)
            make.height.equalTo(256)
        }


        imdbButton.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.height.equalTo(24)
            make.height.equalTo(49)
        }
        rateImageView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(20)
            make.left.equalTo(imdbButton.snp.right).offset(8)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        movieDate.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
        }

        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(56)
            make.left.equalToSuperview().offset(16)
        }

        movieDescLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        movieRate.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(93)
            make.height.equalTo(19)
            make.width.equalTo(60)
        }
    }
}
