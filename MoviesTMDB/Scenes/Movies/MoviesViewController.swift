//
//  MoviesViewController.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit
import SnapKit

final class MoviesViewController: UIViewController, MoviesViewModelOutput {
    func reloadList() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }

    func showProductDetail(_ movie: MovieDetailModel) {
        print("sdasdas")
    }

    // MARK: - UI Components

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentMode = .scaleToFill
        scroll.clipsToBounds = true
        return scroll
    }()

    private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.Identifier.path.rawValue)
            return cv
        }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.Identifier.path.rawValue)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    private lazy var pageController: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 5
        page.currentPage = 0
        page.translatesAutoresizingMaskIntoConstraints = false
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.white
        return page
    }()

    // MARK: - Properties
    private let viewModel: MoviesViewModel

    // MARK: - Initialization
    init(_ viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }

    @available(*, unavailable)
      public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.output = self
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.getUpcomingList()
        viewModel.getNowPlayingList()
        addSubviews()
        setupDelegates()
        setupUI()
    }

    private func addSubviews(){
        //view.addSubview(scrollView)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(pageController)
        view.backgroundColor = .white
    }

    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupUI() {
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.left.right.bottom.equalToSuperview()
//        }
//
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        pageController.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(216)
            make.centerX.equalToSuperview()
            make.width.equalTo(375)
            make.height.equalTo(40)
        }
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(pageController.snp.bottom).offset(0)
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(ScreenSize.height * 0.68)
//            make.width.equalTo(ScreenSize.width)
//        }

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(256)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasourceUpcoming.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:MoviesTableViewCell.Identifier.path.rawValue, for: indexPath) as? MoviesTableViewCell
        cell?.set(viewModel.datasourceUpcoming[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenSize.height * 0.16
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.datasourceNowplaying.count
        }

        // swiftlint:disable force_cast
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? MoviesCollectionViewCell
            cell?.set(viewModel.datasourceNowplaying[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
}
