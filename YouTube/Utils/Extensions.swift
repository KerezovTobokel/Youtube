//
//  File.swift
//  YouTube
//
//  Created by Tobi on 2/10/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import Foundation

extension Date {
    
    struct Date {
        static let iso8601: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate,
                                       .withTime,
                                       .withDashSeparatorInDate,
                                       .withColonSeparatorInTime]
            return formatter
        }()
    }
    
    func toDate_dMMMMyyyyString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, yyyy"     //  9 February, 2018
        return dateFormatter.string(from: self)
    }
}
