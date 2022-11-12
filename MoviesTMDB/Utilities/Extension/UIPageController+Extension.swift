//
//  UIPageController+Extension.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//

import UIKit

extension UIPageControl {
    static func customPageController() -> UIPageControl {
        let page = UIPageControl()
        page.numberOfPages = 5
        page.currentPage = 0
        page.translatesAutoresizingMaskIntoConstraints = false
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.white
        return page
    }
}
