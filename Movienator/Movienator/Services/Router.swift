//
//  Router.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import Foundation

protocol Router {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var urlParameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    
    func makeURLRequest() throws -> URLRequest
}

enum HTTPMethod: String {
    case `get`
    case post
    case put
    case patch
    case delete
}

extension Router {
    func makeURLRequest() throws -> URLRequest {
        let baseURL = URL(string: self.host)!
        let urlPath = baseURL.appendingPathComponent(self.path)
        
        guard var urlComponents = URLComponents(url: urlPath, resolvingAgainstBaseURL: true) else {
            throw RouterError.failedToCreateURLComponents
        }
        
        if let query = urlParameters {
            urlComponents.queryItems = query.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        guard let url = urlComponents.url else {
            throw RouterError.invalidURLComponents
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.httpBody = self.body
        
        return urlRequest
    }
}

enum RouterError: Error {
    case failedToCreateURLComponents
    case invalidURLComponents
}

enum SearchRouter: Router {
    case movie(title: String)
    case tv(title: String)
    
    var host: String {
        switch self {
        case .movie:
            return "https://api.themoviedb.org"
        case .tv:
            return "https://api.themoviedb.org"
        }
    }
    
    
    var path: String {
        switch self {
        case .movie:
            return "/3/search/movie"
        case .tv:
            return "/3/search/tv"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .movie:
            return .get
        case .tv:
            return .get
        }
    }
    
    var urlParameters: [String : Any]? {
        switch self {
        case let .movie(title):
            return ["query": title]
        case let .tv(title):
            return ["query": title]
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var body: Data? {
        nil
    }
}
