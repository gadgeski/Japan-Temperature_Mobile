//
//  StatisticsView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct StatisticsView: View {
    let stats: TemperatureStats
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
            StatCard(value: "\(stats.average)℃", label: "平均気温")
            StatCard(value: "\(stats.max)℃", label: "最高気温")
            StatCard(value: "\(stats.min)℃", label: "最低気温")
            StatCard(value: "\(stats.hotRegions)地域", label: "猛暑地域")
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
    }
}

#Preview {
    StatisticsView(
        stats: TemperatureStats(average: 28, max: 35, min: 20, hotRegions: 2)
    )
}
