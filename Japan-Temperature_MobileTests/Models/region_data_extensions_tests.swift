//
//  RegionDataExtensionsTests.swift
//  Japan-Temperature_MobileTests
//
//  Created by Dev Tech on 2025/07/16.
//

import XCTest
import SwiftUI
@testable import Japan_Temperature_Mobile

// MARK: - RegionData Extensions のテスト
class RegionDataExtensionsTests: XCTestCase {
    
    var sampleRegion: RegionData!
    
    override func setUp() {
        super.setUp()
        sampleRegion = RegionData(
            name: "テスト地方",
            temps: [20, 25, 30, 35, 40],
            comments: ["涼しい", "暖かい", "暑い", "非常に暑い", "猛暑"]
        )
    }
    
    override func tearDown() {
        sampleRegion = nil
        super.tearDown()
    }
    
    // MARK: - 温度カテゴリーテスト
    func testTemperatureCategories() {
        // 涼しい (20℃以下)
        sampleRegion.currentTemp = 15
        XCTAssertEqual(sampleRegion.statusText, "涼しい")
        XCTAssertEqual(sampleRegion.statusEmoji, "🔵")
        XCTAssertEqual(sampleRegion.feelsLike, "涼しく感じます")
        
        // 暖かい (21-28℃)
        sampleRegion.currentTemp = 25
        XCTAssertEqual(sampleRegion.statusText, "暖かい")
        XCTAssertEqual(sampleRegion.statusEmoji, "🟡")
        XCTAssertEqual(sampleRegion.feelsLike, "快適に感じます")
        
        // 暑い (29-35℃)
        sampleRegion.currentTemp = 32
        XCTAssertEqual(sampleRegion.statusText, "暑い")
        XCTAssertEqual(sampleRegion.statusEmoji, "🔴")
        XCTAssertEqual(sampleRegion.feelsLike, "暑く感じます")
        
        // 非常に暑い (36℃以上)
        sampleRegion.currentTemp = 38
        XCTAssertEqual(sampleRegion.statusText, "猛暑")
        XCTAssertEqual(sampleRegion.statusEmoji, "🟣")
        XCTAssertEqual(sampleRegion.feelsLike, "非常に暑く感じます")
    }
    
    // MARK: - 境界値テスト
    func testTemperatureBoundaryValues() {
        // 20℃ちょうど（涼しい）
        sampleRegion.currentTemp = 20
        XCTAssertEqual(sampleRegion.statusText, "涼しい")
        XCTAssertEqual(sampleRegion.statusEmoji, "🔵")
        
        // 21℃（暖かい）
        sampleRegion.currentTemp = 21
        XCTAssertEqual(sampleRegion.statusText, "暖かい")
        XCTAssertEqual(sampleRegion.statusEmoji, "🟡")
        
        // 28℃（暖かい）
        sampleRegion.currentTemp = 28
        XCTAssertEqual(sampleRegion.statusText, "暖かい")
        XCTAssertEqual(sampleRegion.statusEmoji, "🟡")
        
        // 29℃（暑い）
        sampleRegion.currentTemp = 29
        XCTAssertEqual(sampleRegion.statusText, "暑い")
        XCTAssertEqual(sampleRegion.statusEmoji, "🔴")
        
        // 35℃（暑い）
        sampleRegion.currentTemp = 35
        XCTAssertEqual(sampleRegion.statusText, "暑い")
        XCTAssertEqual(sampleRegion.statusEmoji, "🔴")
        
        // 36℃（猛暑）
        sampleRegion.currentTemp = 36
        XCTAssertEqual(sampleRegion.statusText, "猛暑")
        XCTAssertEqual(sampleRegion.statusEmoji, "🟣")
    }
    
    // MARK: - 推奨事項テスト
    func testRecommendations() {
        // 涼しい場合
        sampleRegion.currentTemp = 18
        XCTAssertEqual(sampleRegion.recommendation, "長袖がおすすめです")
        
        // 暖かい場合
        sampleRegion.currentTemp = 24
        XCTAssertEqual(sampleRegion.recommendation, "半袖で快適に過ごせます")
        
        // 暑い場合
        sampleRegion.currentTemp = 33
        XCTAssertEqual(sampleRegion.recommendation, "水分補給をこまめに行いましょう")
        
        // 非常に暑い場合
        sampleRegion.currentTemp = 37
        XCTAssertEqual(sampleRegion.recommendation, "外出時は十分な熱中症対策を")
    }
    
    // MARK: - 健康アドバイステスト
    func testHealthAdvice() {
        // 涼しい場合
        sampleRegion.currentTemp = 18
        XCTAssertEqual(sampleRegion.healthAdvice, "涼しい気候です。軽い運動や散歩に適しています。")
        
        // 暖かい場合
        sampleRegion.currentTemp = 24
        XCTAssertEqual(sampleRegion.healthAdvice, "過ごしやすい気温です。屋外活動に最適な時期です。")
        
        // 暑い場合
        sampleRegion.currentTemp = 33
        XCTAssertEqual(sampleRegion.healthAdvice, "暑い日です。こまめな水分補給と適度な休憩を心がけましょう。")
        
        // 非常に暑い場合
        sampleRegion.currentTemp = 37
        XCTAssertEqual(sampleRegion.healthAdvice, "猛暑日です。外出は控えめに、エアコンを適切に使用し、熱中症対策を万全にしてください。")
    }
    
    // MARK: - 温度カラーテスト
    func testTemperatureColors() {
        // 涼しい場合
        sampleRegion.currentTemp = 18
        XCTAssertEqual(sampleRegion.temperatureColor, Color.blue)
        
        // 暖かい場合
        sampleRegion.currentTemp = 24
        XCTAssertEqual(sampleRegion.temperatureColor, Color.orange)
        
        // 暑い場合
        sampleRegion.currentTemp = 33
        XCTAssertEqual(sampleRegion.temperatureColor, Color.red)
        
        // 非常に暑い場合
        sampleRegion.currentTemp = 37
        XCTAssertEqual(sampleRegion.temperatureColor, Color.pink)
    }
    
    // MARK: - 極端な値のテスト
    func testExtremeValues() {
        // 非常に低い温度
        sampleRegion.currentTemp = -10
        XCTAssertEqual(sampleRegion.statusText, "涼しい")
        XCTAssertEqual(sampleRegion.statusEmoji, "🔵")
        
        // 非常に高い温度
        sampleRegion.currentTemp = 50
        XCTAssertEqual(sampleRegion.statusText, "猛暑")
        XCTAssertEqual(sampleRegion.statusEmoji, "🟣")
    }
    
    // MARK: - グラデーションテスト（構造的な検証）
    func testTemperatureGradients() {
        // 各温度カテゴリーでグラデーションが正しく設定されているか確認
        
        // 涼しい
        sampleRegion.currentTemp = 18
        let coolGradient = sampleRegion.temperatureGradient
        XCTAssertNotNil(coolGradient)
        
        // 暖かい
        sampleRegion.currentTemp = 24
        let warmGradient = sampleRegion.temperatureGradient
        XCTAssertNotNil(warmGradient)
        
        // 暑い
        sampleRegion.currentTemp = 33
        let hotGradient = sampleRegion.temperatureGradient
        XCTAssertNotNil(hotGradient)
        
        // 非常に暑い
        sampleRegion.currentTemp = 37
        let veryHotGradient = sampleRegion.temperatureGradient
        XCTAssertNotNil(veryHotGradient)
    }
}