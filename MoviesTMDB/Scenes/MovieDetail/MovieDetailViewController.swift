//
//  MovieDetailViewController.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit
import Kingfisher
import SafariServices

class MovieDetailViewController: UIViewController {

    // MARK: - UI Components
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView.customView()
    lazy var movieImageView = UIImageView.customImageView()
    lazy var imdbButton = UIButton.customButton()
    lazy var rateImageView = UIImageView.customImageView()
    lazy var movieDate = UILabel.customLabel()
    lazy var movieTitleLabel = UILabel.customLabel()
    lazy var movieDescLabel = UILabel.customLabel()
    lazy var movieRate = UILabel.customLabel()

    // MARK: - Properties
    private let viewModel: MoviesDetailViewModel
    private let movieID: Int
    private var imdb = ""

    // MARK: - Initialization
    init(
        viewModel: MoviesDetailViewModel,
        movieID: Int
    ) {
        self.viewModel = viewModel
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)

    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupUI()
        viewModel.output = self
        viewModel.getProductDetail(movieID)
        view.backgroundColor = .white
        backButton()
    }

    private func backButton() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton

    }
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func websiteButtonTapped(_ sender: UIButton) {

        guard let url = URL(string: "\(Constant.NetworkConstans.MovieServiceEndPoint.getIMDB())\(imdb)") else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
extension MovieDetailViewController: MoviesDetailViewModelOutput {
    func displayProductDetail(_ movie: MovieDetailModel) {
        setDetail(movie)
    }
}

extension MovieDetailViewController {
    func setDetail(_ movie: MovieDetailModel) {
        guard let posterPath = movie.posterPath else {
            return
        }
        guard let imageUrl = URL(string: "\(Constant.NetworkConstans.MovieServiceEndPoint.getImage())\(posterPath)") else {
            return
        }
        DispatchQueue.main.async {
            self.rateImageView.image = UIImage(named: "rate")
            self.movieImageView.kf.setImage(with:imageUrl )
            self.navigationItem.title = "\(String(describing: movie.title ?? "")) (\(Helper.shared.dateFormat(movie.releaseDate, format: "yyyy")))"
            self.movieRate.text = "\(String(format: "%.1f", Double(movie.voteAverage ?? 0)))/10"
            self.movieDate.text = Helper.shared.dateFormat(movie.releaseDate, format: "dd.MM.yyyy")
            self.movieTitleLabel.text = "\(String(describing: movie.title ?? "")) (\(Helper.shared.dateFormat(movie.releaseDate, format: "yyyy")))"
            let descriptionText = movie.overview?
                .replacingOccurrences(of: "<p>", with: "")
                .replacingOccurrences(of: "</p>", with: "")
                .replacingOccurrences(of: "<br>", with: "")
                .replacingOccurrences(of: "<br />", with: "")
            self.movieDescLabel.text = descriptionText
            self.imdb = movie.imdbID ?? ""
        }
    }
}
