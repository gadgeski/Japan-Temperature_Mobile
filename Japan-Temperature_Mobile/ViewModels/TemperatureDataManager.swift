//
//  TemperatureDataManager.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

// MARK: - データマネージャー
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
            RegionData(name: "北海道", temps: [18, 22, 24, 26, 20], comments: ["涼しく過ごしやすい", "散歩日和", "軽装で快適", "外出に最適", "涼しい一日"]),
            RegionData(name: "東北", temps: [25, 27, 29, 24, 26], comments: ["適度な暖かさ", "外出に最適", "少し暑め", "過ごしやすい", "快適な気温"]),
            RegionData(name: "関東", temps: [32, 34, 30, 33, 31], comments: ["暑い一日", "熱中症注意", "適度な暑さ", "暑さ対策必須", "日陰を選んで"]),
            RegionData(name: "中部", temps: [30, 28, 32, 29, 31], comments: ["暑い", "比較的過ごしやすい", "暑さ注意", "適度な暑さ", "日中は暑い"]),
            RegionData(name: "関西", temps: [33, 35, 31, 34, 32], comments: ["暑い一日", "猛暑注意", "暑さ対策を", "非常に暑い", "日中は暑い"]),
            RegionData(name: "中国", temps: [31, 29, 33, 30, 32], comments: ["暑い", "適度な暑さ", "暑さ注意", "暑い一日", "日中は暑い"]),
            RegionData(name: "四国", temps: [32, 30, 34, 31, 33], comments: ["暑い一日", "暑さ対策を", "非常に暑い", "暑い", "暑さ注意"]),
            RegionData(name: "九州", temps: [34, 36, 32, 35, 33], comments: ["暑い一日", "猛暑注意", "暑さ対策を", "非常に暑い", "暑さ注意"]),
            RegionData(name: "沖縄", temps: [36, 38, 34, 37, 35], comments: ["猛暑", "危険な暑さ", "非常に暑い", "猛暑注意", "非常に暑い"])
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
