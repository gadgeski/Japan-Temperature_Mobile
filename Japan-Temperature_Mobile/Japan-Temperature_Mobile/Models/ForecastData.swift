//
//  ForecastData.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

struct ForecastData: Decodable {
    let list: [Forecast]
}

struct Forecast: Decodable {
    let dt_txt: String
    let main: Main
    let weather: [Weather]
}
