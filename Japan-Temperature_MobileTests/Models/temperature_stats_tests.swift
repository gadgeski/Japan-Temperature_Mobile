//
//  TemperatureStatsTests.swift
//  Japan-Temperature_MobileTests
//
//  Created by Dev Tech on 2025/07/16.
//

import XCTest
@testable import Japan_Temperature_Mobile

// MARK: - TemperatureStats のテスト
class TemperatureStatsTests: XCTestCase {
    
    // MARK: - 初期化テスト
    func testTemperatureStatsInitialization() {
        // Given: 統計データ
        let average = 28
        let max = 35
        let min = 20
        let hotRegions = 3
        
        // When: TemperatureStatsを初期化
        let stats = TemperatureStats(
            average: average,
            max: max,
            min: min,
            hotRegions: hotRegions
        )
        
        // Then: 正しく初期化されていることを確認
        XCTAssertEqual(stats.average, average)
        XCTAssertEqual(stats.max, max)
        XCTAssertEqual(stats.min, min)
        XCTAssertEqual(stats.hotRegions, hotRegions)
    }
    
    // MARK: - ゼロ値のテスト
    func testZeroValues() {
        // Given: すべてゼロの統計データ
        let stats = TemperatureStats(
            average: 0,
            max: 0,
            min: 0,
            hotRegions: 0
        )
        
        // When & Then: ゼロ値でも正常に動作する
        XCTAssertEqual(stats.average, 0)
        XCTAssertEqual(stats.max, 0)
        XCTAssertEqual(stats.min, 0)
        XCTAssertEqual(stats.hotRegions, 0)
    }
    
    // MARK: - 負の値のテスト
    func testNegativeValues() {
        // Given: 負の値を含む統計データ
        let stats = TemperatureStats(
            average: -5,
            max: 10,
            min: -20,
            hotRegions: 0
        )
        
        // When & Then: 負の値でも正常に動作する
        XCTAssertEqual(stats.average, -5)
        XCTAssertEqual(stats.max, 10)
        XCTAssertEqual(stats.min, -20)
        XCTAssertEqual(stats.hotRegions, 0)
    }
    
    // MARK: - 極端な値のテスト
    func testExtremeValues() {
        // Given: 極端な値の統計データ
        let stats = TemperatureStats(
            average: 50,
            max: 60,
            min: 40,
            hotRegions: 100
        )
        
        // When & Then: 極端な値でも正常に動作する
        XCTAssertEqual(stats.average, 50)
        XCTAssertEqual(stats.max, 60)
        XCTAssertEqual(stats.min, 40)
        XCTAssertEqual(stats.hotRegions, 100)
    }
    
    // MARK: - 統計データの一貫性テスト
    func testDataConsistency() {
        // Given: 論理的に一貫した統計データ
        let stats = TemperatureStats(
            average: 30,
            max: 40,
            min: 20,
            hotRegions: 2
        )
        
        // When & Then: 最大値が最小値より大きく、平均値が範囲内にある
        XCTAssertGreaterThan(stats.max, stats.min)
        XCTAssertGreaterThanOrEqual(stats.average, stats.min)
        XCTAssertLessThanOrEqual(stats.average, stats.max)
        XCTAssertGreaterThanOrEqual(stats.hotRegions, 0)
    }
    
    // MARK: - 等価性テスト
    func testEquality() {
        // Given: 同じ値を持つ2つの統計データ
        let stats1 = TemperatureStats(average: 25, max: 30, min: 20, hotRegions: 1)
        let stats2 = TemperatureStats(average: 25, max: 30, min: 20, hotRegions: 1)
        
        // When & Then: 同じ値を持つ統計データは等しい
        XCTAssertEqual(stats1.average, stats2.average)
        XCTAssertEqual(stats1.max, stats2.max)
        XCTAssertEqual(stats1.min, stats2.min)
        XCTAssertEqual(stats1.hotRegions, stats2.hotRegions)
    }
    
    // MARK: - 実際の気温データに基づくテスト
    func testRealWorldScenarios() {
        // 夏の日本の典型的な統計
        let summerStats = TemperatureStats(
            average: 32,
            max: 38,
            min: 26,
            hotRegions: 5
        )
        
        XCTAssertEqual(summerStats.average, 32)
        XCTAssertEqual(summerStats.max, 38)
        XCTAssertEqual(summerStats.min, 26)
        XCTAssertEqual(summerStats.hotRegions, 5)
        
        // 冬の日本の典型的な統計
        let winterStats = TemperatureStats(
            average: 8,
            max: 15,
            min: 2,
            hotRegions: 0
        )
        
        XCTAssertEqual(winterStats.average, 8)
        XCTAssertEqual(winterStats.max, 15)
        XCTAssertEqual(winterStats.min, 2)
        XCTAssertEqual(winterStats.hotRegions, 0)
    }
}