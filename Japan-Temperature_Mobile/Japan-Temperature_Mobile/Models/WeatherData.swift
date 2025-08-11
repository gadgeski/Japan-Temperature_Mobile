//
//  WeatherData.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
