//
//  JSONUtils.swift
//  Movienator
//
//  Created by Martin Weiss on 02.06.2023.
//

import Foundation

enum JSONError: Error {
    case encodeFail
    case decodeFail
}

class JSONUtils {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateUtils.format)
        return decoder
    }()
    
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    static func encodeStringArray(_ array: [String]) throws -> String {
        let data = try encoder.encode(array)
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw JSONError.encodeFail
        }
        return jsonString
    }
    
    static func decodeStringArray(from jsonString: String) throws -> [String] {
        guard let data = jsonString.data(using: .utf8) else {
            throw JSONError.decodeFail
        }
        let array = try decoder.decode([String].self, from: data)
        return array
    }
}
