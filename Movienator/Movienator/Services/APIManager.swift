//
//  APIManager.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import Foundation

protocol APIManaging {
    func request<T: Decodable>(_ request: URLRequest) async throws -> T
}

extension APIManaging {
    func request<T: Decodable>(_ router: Router) async throws -> T {
        try await request(try router.makeURLRequest())
    }
}

class APIManager: APIManaging {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func request<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        print("Request for \(request.description)")
        
        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw APIManagerError.noHTTPResponse
        }
        
        guard 200..<300 ~= response.statusCode else {
            throw APIManagerError.wrongStatusCode(code: response.statusCode)
        }
        
        let result = try decoder.decode(T.self, from: data)
        
        print("Response for \(request.url) \(result)")
        return result
    }
}


enum APIManagerError: Error {
    case noHTTPResponse
    case wrongStatusCode(code: Int)
}
