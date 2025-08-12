import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherDescription: String = ""
    @Published var temperature: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather(for city: String) {
        // .env ファイルから API キーを取得
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API_KEYが設定されていません")
        }

        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=ja")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .replaceError(with: WeatherData(main: Main(temp: 0), weather: [Weather(description: "情報取得失敗")]))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weatherData in
                self?.weatherDescription = weatherData.weather.first?.description ?? "情報取得失敗"
                self?.temperature = "\(weatherData.main.temp)℃"
            }
            .store(in: &cancellables)
    }
}
