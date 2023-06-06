//
//  JSONUtils.swift
//  Movienator
//
//  Created by Martin Weiss on 02.06.2023.
//

import Foundation

class JSONUtils {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateUtils.format)
        return decoder
    }()
}
