//
//  ForecastViewModel.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation
import Combine

class ForecastViewModel: ObservableObject {
    @Published var forecasts: [Forecast] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchForecast(for city: String) {
        // .env ファイルから API キーを取得
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API_KEYが設定されていません")
        }

        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric&lang=ja")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ForecastData.self, decoder: JSONDecoder())
            .replaceError(with: ForecastData(list: []))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] forecastData in
                self?.forecasts = forecastData.list
            }
            .store(in: &cancellables)
    }
}
