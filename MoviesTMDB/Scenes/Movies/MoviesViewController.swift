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
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.Identifier.path.rawValue)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
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
        page.pageIndicatorTintColor = UIColor.blue
        page.currentPageIndicatorTintColor = UIColor.systemRed
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
        viewModel.getUpcomingList()
        viewModel.datasourceNowplaying
        addSubviews()
        setupDelegates()
        setupUI()
    }

    private func addSubviews(){
        //view.addSubview(scrollView)
        //scrollView.addSubview(collectionView)
        view.addSubview(tableView)
        //scrollView.addSubview(pageController)
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
//        collectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(ScreenSize.height * 0.26)
//            make.width.equalTo(ScreenSize.width)
//        }
//        pageController.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom).offset(-2)
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(ScreenSize.height * 0.05)
//            make.width.equalTo(ScreenSize.width)
//        }
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(pageController.snp.bottom).offset(0)
//            make.left.right.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(ScreenSize.height * 0.68)
//            make.width.equalTo(ScreenSize.width)
//        }

        tableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
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
