//
//  DateUtils.swift
//  Movienator
//
//  Created by Martin Weiss on 02.06.2023.
//

import Foundation

class DateUtils {
    static let format: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
}
