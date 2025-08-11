//
//  ForecastView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/11.
//

import SwiftUI

struct ForecastView: View {
    @StateObject private var viewModel = ForecastViewModel()
    
    var body: some View {
        List(viewModel.forecasts, id: \.dt_txt) { forecast in
            VStack(alignment: .leading) {
                Text(forecast.dt_txt)
                Text("天気: \(forecast.weather.first?.description ?? "情報取得失敗")")
                Text("気温: \(forecast.main.temp)℃")
            }
        }
        .onAppear {
            viewModel.fetchForecast(for: "Tokyo")
        }
    }
}
