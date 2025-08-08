import Foundation

struct HistoricalTemperature: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double
}