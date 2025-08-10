//
//  RegionTemperature.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

struct RegionTemperature: Identifiable, Equatable {
    let id: String      // 例: "hokkaido", "kanto"
    let name: String    // 表示名
    var temperatureC: Double
    // フェーズ1で追加（nilならUI/計算側が安全に処理）
    var humidity: Double?     // 0...1（相対湿度）
    var windSpeedMS: Double?  // m/s
}
