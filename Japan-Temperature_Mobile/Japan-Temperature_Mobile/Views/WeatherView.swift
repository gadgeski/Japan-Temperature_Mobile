//
//  WeatherView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/11.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            Text("天気: \(viewModel.weatherDescription)")
            Text("気温: \(viewModel.temperature)")
        }
        .onAppear {
            viewModel.fetchWeather(for: "Tokyo")
        }
    }
}
