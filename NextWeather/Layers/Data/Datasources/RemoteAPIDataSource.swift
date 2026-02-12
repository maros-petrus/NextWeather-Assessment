//
//  RemoteAPIDataSource.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import Foundation

protocol RemoteAPIDataSource {
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}

class URLSessionRemoteApiDataSource: RemoteAPIDataSource {
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        let request = try endpoint.makeRequest()
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
            guard (200..<300).contains(response.statusCode) else { throw NetworkError.httpStatus(response.statusCode) }
            
            return try decoder.decode(T.self, from: data)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.transportError(error.localizedDescription)
        }
    }
}

public struct Endpoint {
    public let baseURL: String
    public let path: String
    public let method: HTTPMethod
    public let queryItems: [URLQueryItem]
    
    init(baseURL: String, path: String, method: HTTPMethod, queryItems: [URLQueryItem]) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }
    
    public func makeRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL) else { throw NetworkError.invalidURL }
        var components = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = components?.url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

public enum HTTPMethod: String {
    case get = "GET"
}

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decodingFailed
    case transportError(String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL: "Invalid URL."
        case .invalidResponse: "Invalid response."
        case .httpStatus(let code): "HTTP error \(code)"
        case .decodingFailed: "Failed to decode response."
        case .transportError(let message): message
        }
    }
}
