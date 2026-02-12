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
        let temperature2m: [Double]
        let apparentTemperature: [Double]

        enum CodingKeys: String, CodingKey {
            case time
            case temperature2m = "temperature_2m"
            case apparentTemperature = "apparent_temperature"
        }
    }
}
