//
//  SampleData.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

enum SampleData {
    static let sampleRegions: [RegionTemperature] = [
        .init(id: "hokkaido", name: "北海道", temperatureC: -2.0, humidity: 0.6, windSpeedMS: 3.0),
        .init(id: "tohoku", name: "東北", temperatureC: 3.5, humidity: 0.55, windSpeedMS: 2.0),
        .init(id: "kanto", name: "関東", temperatureC: 12.2, humidity: 0.5, windSpeedMS: 1.5),
        .init(id: "chubu", name: "中部", temperatureC: 10.0, humidity: 0.45, windSpeedMS: 1.2),
        .init(id: "kinki", name: "近畿", temperatureC: 18.4, humidity: 0.5, windSpeedMS: 1.0),
        .init(id: "chugoku", name: "中国", temperatureC: 20.2, humidity: 0.55, windSpeedMS: 0.8),
        .init(id: "shikoku", name: "四国", temperatureC: 21.7, humidity: 0.6, windSpeedMS: 0.7),
        .init(id: "kyushu", name: "九州", temperatureC: 23.1, humidity: 0.65, windSpeedMS: 1.1),
        .init(id: "okinawa", name: "沖縄", temperatureC: 26.8, humidity: 0.75, windSpeedMS: 2.2),
    ]
}
