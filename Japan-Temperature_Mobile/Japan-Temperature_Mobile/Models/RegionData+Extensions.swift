//
//  RegionData+Extensions.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

// MARK: - RegionData Extensions
extension RegionData {
    var temperatureColor: Color {
        switch currentTemp {
        case ...20: return Color.blue
        case 21...28: return Color.orange
        case 29...35: return Color.red
        case 36...: return Color.pink
        default: return Color.gray
        }
    }
    
    var temperatureGradient: LinearGradient {
        switch currentTemp {
        case ...20:
            return LinearGradient(colors: [Color(red: 0.31, green: 0.76, blue: 0.97), Color(red: 0.16, green: 0.71, blue: 0.96)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 21...28:
            return LinearGradient(colors: [Color(red: 1.0, green: 0.72, blue: 0.30), Color(red: 1.0, green: 0.60, blue: 0.0)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 29...35:
            return LinearGradient(colors: [Color(red: 1.0, green: 0.44, blue: 0.26), Color(red: 0.96, green: 0.26, blue: 0.21)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 36...:
            return LinearGradient(colors: [Color(red: 0.91, green: 0.12, blue: 0.39), Color(red: 0.76, green: 0.10, blue: 0.36)], startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(colors: [Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    var statusText: String {
        switch currentTemp {
        case ...20: return "涼しい"
        case 21...28: return "暖かい"
        case 29...35: return "暑い"
        case 36...: return "猛暑"
        default: return "不明"
        }
    }
    
    var statusEmoji: String {
        switch currentTemp {
        case ...20: return "🔵"
        case 21...28: return "🟡"
        case 29...35: return "🔴"
        case 36...: return "🟣"
        default: return "⚪"
        }
    }
    
    var feelsLike: String {
        switch currentTemp {
        case ...20: return "涼しく感じます"
        case 21...28: return "快適に感じます"
        case 29...35: return "暑く感じます"
        case 36...: return "非常に暑く感じます"
        default: return "不明"
        }
    }
    
    var recommendation: String {
        switch currentTemp {
        case ...20: return "長袖がおすすめです"
        case 21...28: return "半袖で快適に過ごせます"
        case 29...35: return "水分補給をこまめに行いましょう"
        case 36...: return "外出時は十分な熱中症対策を"
        default: return "気温に応じた服装を"
        }
    }
    
    var healthAdvice: String {
        switch currentTemp {
        case ...20: return "涼しい気候です。軽い運動や散歩に適しています。"
        case 21...28: return "過ごしやすい気温です。屋外活動に最適な時期です。"
        case 29...35: return "暑い日です。こまめな水分補給と適度な休憩を心がけましょう。"
        case 36...: return "猛暑日です。外出は控えめに、エアコンを適切に使用し、熱中症対策を万全にしてください。"
        default: return "気温に応じた対策を心がけましょう。"
        }
    }
}
