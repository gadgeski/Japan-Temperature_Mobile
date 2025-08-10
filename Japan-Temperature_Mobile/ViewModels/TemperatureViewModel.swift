//
//  TemperatureViewModel.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation
import Combine

final class TemperatureViewModel: ObservableObject {
    @Published private(set) var regions: [RegionTemperature] = []
    @Published var unit: TemperatureUnit = TemperatureViewModel.defaultUnit()
    @Published var sortDescending: Bool = true

    // 起動中のみの履歴保持
    private let historyLimit = 3
    @Published private(set) var history: [String: [Double]] = [:] // id -> [temps]

    // iOS16以降は measurementSystem、未満は usesMetricSystem を使用
    private static func defaultUnit(for locale: Locale = .current) -> TemperatureUnit {
        if #available(iOS 16.0, *) {
            let ms = locale.measurementSystem
            // UKは温度が摂氏なので metric と同等に扱う
            return (ms == .metric || ms == .uk) ? .celsius : .fahrenheit
        } else {
            return locale.usesMetricSystem ? .celsius : .fahrenheit
        }
    }

    init(initialData: [RegionTemperature]) {
        self.regions = initialData
        for r in regions { history[r.id] = [r.temperatureC] }
        applySort()
    }

    func updateData(newData: [RegionTemperature]) {
        self.regions = newData
        for r in newData {
            var arr = history[r.id] ?? []
            arr.append(r.temperatureC)
            if arr.count > historyLimit { arr.removeFirst(arr.count - historyLimit) }
            history[r.id] = arr
        }
        applySort()
    }

    func applySort() {
        if sortDescending {
            regions.sort {
                if $0.temperatureC == $1.temperatureC { return $0.id < $1.id }
                return $0.temperatureC > $1.temperatureC
            }
        } else {
            regions.sort {
                if $0.temperatureC == $1.temperatureC { return $0.id < $1.id }
                return $0.temperatureC < $1.temperatureC
            }
        }
    }

    // -1:下降 0:横ばい 1:上昇
    func trend(for id: String) -> Int {
        guard let arr = history[id], arr.count >= 2 else { return 0 }
        let last = arr[arr.count - 1]
        let prev = arr[arr.count - 2]
        if last - prev > 0.2 { return 1 }
        if prev - last > 0.2 { return -1 }
        return 0
    }

    func apparentCelsius(for region: RegionTemperature) -> Double {
        ApparentTemperature.computeCelsius(
            tempC: region.temperatureC,
            humidity: region.humidity,
            windMS: region.windSpeedMS
        )
    }
}
