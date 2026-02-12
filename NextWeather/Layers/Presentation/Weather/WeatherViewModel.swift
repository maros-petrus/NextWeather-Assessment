//
//  WeatherViewModel.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import Combine

class WeatherViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case loaded
        case failed(String)
    }
    
    @Published var state: State = .loaded
    
    func load() async {
        // TODO: Load data and manage state
    }
}
