import SwiftUI
import Charts

struct GraphView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let selectedRegion: String

    var body: some View {
        VStack {
            Text("\(selectedRegion)の過去30日間の気温")
                .font(.headline)
            
            if !viewModel.historicalData.isEmpty {
                Chart {
                    ForEach(viewModel.historicalData) { data in
                        LineMark(
                            x: .value("日付", data.date, unit: .day),
                            y: .value("気温", data.temperature)
                        )
                        .foregroundStyle(.blue)
                        .symbol(.circle)
                    }
                }
                .chartYAxisLabel("気温 (°C)")
                .chartXAxisLabel("日付")
                .frame(height: 250)
                .padding()
            } else {
                Text("過去の気温データがありません。")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.fetchHistoricalData(for: selectedRegion)
        }
    }
}