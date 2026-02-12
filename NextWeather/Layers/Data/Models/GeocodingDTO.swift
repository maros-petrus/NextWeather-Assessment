//
//  GeocodingDTO.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import Foundation

struct GeocodingDTO: Decodable {
    let results: [ResultDTO]
    struct ResultDTO: Decodable {
        let latitude: Double
        let longitude: Double
        let name: String
        let country: String?
    }
}
