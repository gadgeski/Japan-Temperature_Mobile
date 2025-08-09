//
//  RegionDetailView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI
import Charts

struct RegionDetailView: View {
    let region: RegionData
    @State private var showGraph = false
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button("過去の気温グラフを表示") {
                showGraph.toggle()
            }
            .padding()
            .sheet(isPresented: $showGraph) {
                GraphView(viewModel: weatherViewModel, selectedRegion: region.name)
            }
            // ヘッダー
            HStack {
                Text("\(region.statusEmoji) \(region.name)地方")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.30, green: 0.69, blue: 0.31))
                Spacer()
            }
            
            // 気温情報
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("🌡️ 現在の最高気温:")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text("\(region.currentTemp)℃")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(region.temperatureGradient)
                        .cornerRadius(12)
                }
                
                DetailRow(icon: "☀️", title: "今日の天気:", content: region.currentComment)
                DetailRow(icon: "👕", title: "服装の推奨:", content: region.recommendation)
                DetailRow(icon: "🤗", title: "体感:", content: region.feelsLike)
                DetailRow(icon: "📊", title: "温度区分:", content: region.statusText)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(12)
            
            // アドバイス
            VStack(alignment: .leading, spacing: 10) {
                Text("💡 アドバイス:")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(region.healthAdvice)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(UIColor.systemBlue).opacity(0.1))
            .cornerRadius(12)
            .overlay(
                Rectangle()
                    .fill(Color(red: 0.30, green: 0.69, blue: 0.31))
                    .frame(width: 4)
                    .clipped(),
                alignment: .leading
            )
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
    }
}

#Preview {
    let sampleRegion = RegionData(name: "北海道", temps: [18, 22, 24, 26, 20], comments: ["涼しく過ごしやすい", "散歩日和"])
    
    return RegionDetailView(region: sampleRegion)
}
