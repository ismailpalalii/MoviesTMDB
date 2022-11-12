//
//  MoviesViewController.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit

final class MoviesViewController: UIViewController {

    // MARK: - UI Components

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentMode = .scaleAspectFit
        scroll.backgroundColor = .black
        scroll.layer.cornerRadius = 15
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
        page.numberOfPages = 3
        page.currentPage = 0
        page.translatesAutoresizingMaskIntoConstraints = false
        page.pageIndicatorTintColor = UIColor.black
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
        view.backgroundColor = .red
    }
}
