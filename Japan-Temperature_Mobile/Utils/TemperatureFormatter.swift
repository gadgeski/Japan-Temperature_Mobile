//
//  TemperatureFormatter.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

struct TemperatureFormatter {
    static func display(_ celsius: Double, unit: TemperatureUnit, locale: Locale = .current) -> String {
        let isMetric: Bool
        if #available(iOS 16.0, *) {
            isMetric = locale.measurementSystem == .metric
        } else {
            isMetric = locale.usesMetricSystem
        }
        
        switch unit {
        case .celsius:
            return String(format: isMetric ? "%.1f℃" : "%.1f C", celsius)
        case .fahrenheit:
            let f = celsius * 9.0 / 5.0 + 32.0
            return String(format: "%.1f℉", f)
        }
    }
}
