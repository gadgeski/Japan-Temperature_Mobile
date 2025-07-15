//
//  TemperatureDataManager.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI
import Combine

class TemperatureDataManager: ObservableObject {
    @Published var regions: [RegionData] = []
    @Published var selectedRegion: RegionData?
    @Published var lastUpdate: Date = Date()
    @Published var sortOrder: SortOrder = .geographic
    
    enum SortOrder {
        case geographic
        case temperature
    }
    
    init() {
        initializeData()
    }
    
    private func initializeData() {
        regions = [
            RegionData(
                name: "北海道",
                temps: [18, 22, 24, 26, 20],
                comments: ["涼しく過ごしやすい", "散歩日和", "軽装で快適", "外出に最適", "涼しい一日"]
            ),
            RegionData(
                name: "東北",
                temps: [25, 27, 29, 24, 26],
                comments: ["適度な暖かさ", "外出に最適", "少し暑め", "過ごしやすい", "快適な気温"]
            ),
            // 他の地方データ...
        ]
    }
    
    func updateAllTemperatures() {
        for i in 0..<regions.count {
            regions[i].updateTemperature()
        }
        lastUpdate = Date()
    }
    
    func sortByTemperature() {
        regions.sort { $0.currentTemp > $1.currentTemp }
        sortOrder = .temperature
    }
    
    func sortByRegion() {
        let regionOrder = ["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州", "沖縄"]
        regions.sort { region1, region2 in
            let index1 = regionOrder.firstIndex(of: region1.name) ?? 0
            let index2 = regionOrder.firstIndex(of: region2.name) ?? 0
            return index1 < index2
        }
        sortOrder = .geographic
    }
    
    func getStats() -> TemperatureStats {
        let temps = regions.map { $0.currentTemp }
        let average = temps.reduce(0, +) / temps.count
        let max = temps.max() ?? 0
        let min = temps.min() ?? 0
        let hotRegions = temps.filter { $0 > 35 }.count
        return TemperatureStats(average: average, max: max, min: min, hotRegions: hotRegions)
    }
}
