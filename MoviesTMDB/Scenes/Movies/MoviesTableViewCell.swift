//
//  MoviesTableViewCell.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit
import Kingfisher

final class MoviesTableViewCell: UITableViewCell {

    lazy var movieImage = UIImageView.customImageView()
    lazy var movieTitle = UILabel.customLabel()
    lazy var movieDescription = UILabel.customLabel()
    lazy var movieDate = UILabel.customLabel()
    lazy var arrowImage = UIImageView.customImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewConfigure()
        setupUI()
    }

    enum Identifier: String {
        case path = "TableViewCell"
    }
    
    @available(*, unavailable)
      public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
      }
}
