import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    // 他のプロパティとメソッド...

    @Published var historicalData: [HistoricalTemperature] = []

    func fetchHistoricalData(for region: String) {
        // ここで実際のAPIから過去データを取得するロジックを実装します。
        // 以下はデモ用のデータ生成例です。
        let calendar = Calendar.current
        let today = Date()
        var demoData: [HistoricalTemperature] = []

        for i in 0..<30 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let randomTemp = Double.random(in: 15.0...30.0)
                demoData.append(HistoricalTemperature(date: date, temperature: randomTemp))
            }
        }
        self.historicalData = demoData.sorted { $0.date < $1.date }
    }
}