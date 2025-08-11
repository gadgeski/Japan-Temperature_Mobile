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
                            x: .value("日付", data.date /*, unit: .day*/),
                            y: .value("気温", data.temperature)
                        )
                        // .symbol(.circle) は使わない（環境によって落ちる）

                        // 点を打ちたい場合は PointMark を追加
                        PointMark(
                            x: .value("日付", data.date),
                            y: .value("気温", data.temperature)
                        )
                    }
                }
                .chartYAxisLabel {
                    Text("気温 (°C)")
                }
                .chartXAxisLabel {
                    Text("日付")
                }
                .frame(height: 250)
                .padding()
            } else {
                Text("過去の気温データがありません。")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            // どちらか、あなたの ViewModel に合わせて：
            // viewModel.fetchHistoricalData(for: selectedRegion)    // 実API版があるなら
            viewModel.fetchHistoricalDataDemo()                      // ダミー生成版ならこちら
        }
    }
}
