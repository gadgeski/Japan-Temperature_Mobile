//
//  ApparentTemperature.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

enum ApparentTempMethod {
    case heatIndexLike
    case windChillLike
    case neutral
}

struct ApparentTemperature {
    static func method(for tempC: Double, humidity: Double?, windMS: Double?) -> ApparentTempMethod {
        if tempC >= 26, let h = humidity, h >= 0.4 { return .heatIndexLike }
        if tempC <= 10, let w = windMS, w >= 1.5 { return .windChillLike }
        return .neutral
    }

    static func computeCelsius(tempC: Double, humidity: Double?, windMS: Double?) -> Double {
        switch method(for: tempC, humidity: humidity, windMS: windMS) {
        case .heatIndexLike:
            let h = max(0.0, min(humidity ?? 0.5, 1.0))
            let bonus = (tempC - 26) * 0.25 + h * 4.0
            return tempC + max(0, bonus)
        case .windChillLike:
            let w = max(0.0, windMS ?? 0.0)
            let loss = (10 - tempC) * 0.12 + w * 0.4
            return tempC - max(0, loss)
        case .neutral:
            return tempC
        }
    }
}
