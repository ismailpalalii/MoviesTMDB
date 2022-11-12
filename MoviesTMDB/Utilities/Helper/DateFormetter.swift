//
//  DateFormetter.swift
//  MoviesTMDB
//
//  Created by İsmail Palalı on 12.11.2022.
//
import Foundation

class Helper {
    static let shared = Helper()

    public func dateFormat(_ date: String?, format: String) -> String{
        guard let date = date else {
            return ""
        }
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")
        fmt.dateFormat = "yyyy-MM-dd"
        let dt = fmt.date(from: date)!
        fmt.dateFormat = format
        return fmt.string(from: dt)
    }
}
