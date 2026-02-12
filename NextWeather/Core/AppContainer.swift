//
//  AppContainer.swift
//  NextWeather
//
//  Created by Maros Petrus on 12.02.26.
//

import Foundation

class AppContainer {
    let remoteDataSource: RemoteAPIDataSource = URLSessionRemoteAPIDataSource()
    lazy var weatherRepository = WeatherRepository(datasource: remoteDataSource)
    
    // TODO: Add Domain dependencies
}
