//
//  NextWeatherApp.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import SwiftUI

@main
struct NextWeatherApp: App {
    
    private let container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: .init(
                // TODO: Inject dependencies
            ))
        }
    }
}
