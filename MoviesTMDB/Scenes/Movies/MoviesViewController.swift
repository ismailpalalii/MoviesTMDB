//
//  MoviesViewController.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//


//
//  MoviesViewController.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//
import UIKit
import SnapKit

final class MoviesViewController: UIViewController {

    // MARK: - UI Components
    lazy var collectionView = UICollectionView.customCollectionView()
    lazy var tableView = UITableView.customTableView()
    lazy var pageController = UIPageControl.customPageController()
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var activityIndicator = UIActivityIndicatorView()

    // MARK: - Properties
    private let viewModel: MoviesViewModel
    private var currentPage = 0

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
        fetchList()
        addSubviews()
        setupDelegates()
        setupUI()
        configureRefreshControl()
    }

    private func fetchList() {
        viewModel.output = self
        activityIndicator.startAnimating()
        viewModel.getUpcomingList()
        viewModel.getNowPlayingList()
    }
    @objc func handleRefreshControl() {
       fetchList()
        self.activityIndicator.startAnimating()
       DispatchQueue.main.async {
          self.scrollView.refreshControl?.endRefreshing()
           self.activityIndicator.stopAnimating()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAtTableview(indexPath)
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

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel.didSelectItemAtCollectionView(indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.row
    }
}

// MARK: - MoviesViewModelOutput Output
extension MoviesViewController: MoviesViewModelOutput {
    func reloadList() {
        activityIndicator.stopAnimating()
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }

    func showProductDetail(
        _ movie: Movie
    ) {
        let viewModel = MoviesDetailViewModel(service: Services() as! ServiceProtocol)
        let controller = MovieDetailViewController(viewModel: viewModel, movieID: movie.id)
        navigationController?.pushViewController(
            controller,
            animated: true
        )
    }
}
