//
//  MovieDetailViewController.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var movieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private var imdbImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private var rateImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()


    private var movieDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .black
        return label
    }()

    private var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private var movieDescLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private var movieRate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 13)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    
    // MARK: - Properties
    private let viewModel: MoviesDetailViewModel
    private let movieID: Int

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

    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
        contentView.addSubview(imdbImageView)
        contentView.addSubview(rateImageView)
        contentView.addSubview(movieDate)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieDescLabel)
        contentView.addSubview(movieRate)
        contentView.backgroundColor = .white
        scrollView.backgroundColor = .white
    }

    private func setupUI(){
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


               imdbImageView.snp.makeConstraints { make in
                   make.top.equalTo(movieImageView.snp.bottom).offset(16)
                   make.left.equalTo(16)
                   make.height.equalTo(24)
                   make.height.equalTo(49)
               }
                rateImageView.snp.makeConstraints { make in
                    make.top.equalTo(movieImageView.snp.bottom).offset(20)
                    make.left.equalTo(imdbImageView.snp.right).offset(8)
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
            make.width.equalTo(40)
        }
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
            self.imdbImageView.image = UIImage(named: "imdb")
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
        }
    }
}
