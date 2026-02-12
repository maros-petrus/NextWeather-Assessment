//
//  WeatherRepository.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import Foundation

class WeatherRepository {
    private let datasource: RemoteAPIDataSource
    private let baseURL = "https://api.open-meteo.com"
    
    init(datasource: RemoteAPIDataSource) {
        self.datasource = datasource
    }
    
    func fetchCurrentWeather(city: String) async throws -> WeatherDTO {
        guard let coordinates = try await getCityCoordinates(city: city) else { throw WeatherRepositoryError.cityNotFound(city) }
        
        let endpoint = Endpoint(
            baseURL: baseURL,
            path: "/v1/forecast",
            method: .get,
            queryItems: [
                .init(name: "latitude", value: "\(coordinates.latitude)"),
                .init(name: "longitude", value: "\(coordinates.longitude)"),
                .init(name: "hourly", value: "temperature_2m,apparent_temperature"),
                .init(name: "forecast_days", value: "1"),
                .init(name: "timeformat", value: "iso8601"),
                .init(name: "timezone", value: "auto")
            ]
        )
        
        return try await datasource.request(endpoint, as: WeatherDTO.self)
    }
    
    private func getCityCoordinates(city: String) async throws -> GeocodingDTO.ResultDTO? {
        let endpoint = Endpoint(
            baseURL: "https://geocoding-api.open-meteo.com",
            path: "/v1/search",
            method: .get,
            queryItems: [
                .init(name: "name", value: city),
                .init(name: "count", value: "1"),
                .init(name: "language", value: "en"),
                .init(name: "format", value: "json")
            ]
        )
        
        let geocoding = try await datasource.request(endpoint, as: GeocodingDTO.self)
        return geocoding.results?.first
    }
    
    enum WeatherRepositoryError: Error {
        case cityNotFound(String)
    }
}
