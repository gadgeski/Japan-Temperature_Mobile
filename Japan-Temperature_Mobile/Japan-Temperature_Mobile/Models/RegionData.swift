//
//  RegionData.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import Foundation

// MARK: - データモデル
struct RegionData {
    let name: String
    let temps: [Int]
    let comments: [String]
    var currentTemp: Int
    var currentComment: String
    
    init(name: String, temps: [Int], comments: [String]) {
        self.name = name
        self.temps = temps
        self.comments = comments
        self.currentTemp = temps.randomElement() ?? 20
        self.currentComment = comments.randomElement() ?? ""
    }
    
    mutating func updateTemperature() {
        self.currentTemp = temps.randomElement() ?? 20
        self.currentComment = comments.randomElement() ?? ""
    }
}

