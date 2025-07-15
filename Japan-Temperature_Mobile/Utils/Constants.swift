//
//  Constants.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import Foundation

struct AppConstants {
    static let regionOrder = ["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州", "沖縄"]
    
    struct TemperatureThresholds {
        static let cool = 20
        static let warm = 28
        static let hot = 35
    }
    
    struct UI {
        static let cornerRadius: CGFloat = 15
        static let cardPadding: CGFloat = 15
        static let standardSpacing: CGFloat = 20
    }
}
