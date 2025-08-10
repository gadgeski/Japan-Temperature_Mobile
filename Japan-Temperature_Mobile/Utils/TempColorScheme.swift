//
//  TempColorScheme.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import SwiftUI

enum TempBand: Int, CaseIterable {
    case frigid, cold, mild, warm, hot, extreme
}

struct TempColorScheme {
    static func band(for tempC: Double) -> TempBand {
        switch tempC {
        case ..<0:    return .frigid
        case 0..<10:  return .cold
        case 10..<20: return .mild
        case 20..<30: return .warm
        case 30..<35: return .hot
        default:      return .extreme
        }
    }

    static func color(for band: TempBand, colorScheme: ColorScheme, accessibility: Bool) -> Color {
        switch band {
        case .frigid:  return accessibility ? Color.blue.opacity(0.9)    : Color.blue.opacity(0.7)
        case .cold:    return accessibility ? Color.cyan.opacity(0.9)    : Color.cyan.opacity(0.7)
        case .mild:    return accessibility ? Color.green.opacity(0.9)   : Color.green.opacity(0.7)
        case .warm:    return accessibility ? Color.orange.opacity(0.95) : Color.orange.opacity(0.75)
        case .hot:     return accessibility ? Color.red.opacity(0.95)    : Color.red.opacity(0.75)
        case .extreme: return accessibility ? Color.red                  : Color.red.opacity(0.85)
        }
    }
}
