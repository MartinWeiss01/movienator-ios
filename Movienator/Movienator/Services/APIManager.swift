//
//  APIManager.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import Foundation

class APIManager: TMDBService {
    private let apiKey = "2bfe8a9fe7b131bc521523d404e2c9c5"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONUtils.decoder
    
    func searchMovie(query: String) async throws -> [SearchResultDetail] {
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
                    throw MovieError.invalidEndpoint
                }
        let movieResponse: SearchMovieResponseDTO = try await self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ])
        
        return movieResponse.results
    }
    
    func discoverMovie(tmdbId: Int64) async throws -> [SearchResultDetail] {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(tmdbId)/recommendations") else {
                    throw MovieError.invalidEndpoint
                }
        let movieResponse: SearchMovieResponseDTO = try await self.loadURLAndDecode(url: url, params: [
            "language": "en-US"
        ])
        
        return movieResponse.results
    }
    
    func searchTVSeries(query: String) async throws -> [SearchTVResultDetail] {
        guard let url = URL(string: "\(baseAPIURL)/search/tv") else {
                    throw MovieError.invalidEndpoint
                }
        let tvResponse: SearchTVResponseDTO = try await self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ])

        return tvResponse.results
    }
    
    func discoverTVSeries(tmdbId: Int64) async throws -> [SearchTVResultDetail] {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(tmdbId)/recommendations") else {
                    throw MovieError.invalidEndpoint
                }
        let tvResponse: SearchTVResponseDTO = try await self.loadURLAndDecode(url: url, params: [
            "language": "en-US"
        ])

        return tvResponse.results
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil) async throws -> D {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw MovieError.invalidEndpoint
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            throw MovieError.invalidEndpoint
        }
        
        let (data, response) = try await urlSession.data(from: finalURL)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw MovieError.invalidResponse
        }
        
        return try self.jsonDecoder.decode(D.self, from: data)
    }
}
