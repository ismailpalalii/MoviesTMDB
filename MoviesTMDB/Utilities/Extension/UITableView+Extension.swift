//
//  UITableView+Extension.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit

extension UITableView {
    static func customTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = ScreenSize.height * 0.24
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.Identifier.path.rawValue)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
}
