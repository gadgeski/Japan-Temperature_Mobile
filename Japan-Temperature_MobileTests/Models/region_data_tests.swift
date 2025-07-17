//
//  RegionDataTests.swift
//  Japan-Temperature_MobileTests
//
//  Created by Dev Tech on 2025/07/16.
//

import XCTest
@testable import Japan_Temperature_Mobile

// MARK: - RegionData のテスト
class RegionDataTests: XCTestCase {
    
    var sampleRegion: RegionData!
    
    override func setUp() {
        super.setUp()
        // テスト用のサンプルデータを作成
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
    
    // MARK: - 初期化テスト
    func testRegionDataInitialization() {
        // Given: サンプルデータ
        let name = "北海道"
        let temps = [18, 22, 24, 26, 20]
        let comments = ["涼しい", "快適"]
        
        // When: RegionDataを初期化
        let region = RegionData(name: name, temps: temps, comments: comments)
        
        // Then: 正しく初期化されていることを確認
        XCTAssertEqual(region.name, name)
        XCTAssertEqual(region.temps, temps)
        XCTAssertEqual(region.comments, comments)
        XCTAssertTrue(temps.contains(region.currentTemp))
        XCTAssertTrue(comments.contains(region.currentComment))
    }
    
    // MARK: - 温度更新テスト
    func testUpdateTemperature() {
        // Given: 元の温度とコメントを記録
        let originalTemp = sampleRegion.currentTemp
        let originalComment = sampleRegion.currentComment
        
        // When: 温度を更新（100回実行して確実に変更を検証）
        var tempChanged = false
        var commentChanged = false
        
        for _ in 0..<100 {
            sampleRegion.updateTemperature()
            if sampleRegion.currentTemp != originalTemp {
                tempChanged = true
            }
            if sampleRegion.currentComment != originalComment {
                commentChanged = true
            }
        }
        
        // Then: 温度とコメントが候補の中から選ばれていることを確認
        XCTAssertTrue(sampleRegion.temps.contains(sampleRegion.currentTemp))
        XCTAssertTrue(sampleRegion.comments.contains(sampleRegion.currentComment))
        // 確率的に変更されることを確認（100回実行すれば変更される可能性が高い）
        XCTAssertTrue(tempChanged || commentChanged)
    }
    
    // MARK: - 温度更新の独立性テスト
    func testUpdateTemperatureIndependence() {
        // Given: 同じ設定の2つの地域
        var region1 = RegionData(name: "地域1", temps: [20, 25, 30], comments: ["A", "B", "C"])
        var region2 = RegionData(name: "地域2", temps: [20, 25, 30], comments: ["A", "B", "C"])
        
        // When: 一方の地域の温度を更新
        region1.updateTemperature()
        
        // Then: もう一方の地域は影響を受けない
        XCTAssertNotEqual(region1.currentTemp, region2.currentTemp)
    }
    
    // MARK: - 空の配列に対するテスト
    func testEmptyArraysHandling() {
        // Given: 空の配列を持つ地域データ
        let region = RegionData(name: "空の地域", temps: [], comments: [])
        
        // When & Then: 空の配列でも初期化は成功し、デフォルト値が設定される
        XCTAssertEqual(region.name, "空の地域")
        XCTAssertEqual(region.temps, [])
        XCTAssertEqual(region.comments, [])
        XCTAssertEqual(region.currentTemp, 20) // デフォルト値
        XCTAssertEqual(region.currentComment, "") // デフォルト値
    }
    
    // MARK: - 単一要素配列のテスト
    func testSingleElementArrays() {
        // Given: 単一要素の配列を持つ地域データ
        let region = RegionData(name: "単一地域", temps: [25], comments: ["快適"])
        
        // When & Then: 単一要素でも正常に動作する
        XCTAssertEqual(region.currentTemp, 25)
        XCTAssertEqual(region.currentComment, "快適")
    }
}