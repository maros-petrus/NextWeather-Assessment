//
//  WeatherDTO.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import Foundation

struct WeatherDTO: Codable {
    let hourly: Hourly
    struct Hourly: Codable {
        let time: [String]
        let temperature_2m: [Double]
        let apparent_temperature: [Double]
    }
}
