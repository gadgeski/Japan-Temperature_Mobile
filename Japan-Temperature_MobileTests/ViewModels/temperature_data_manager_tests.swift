//
//  TemperatureDataManagerTests.swift
//  Japan-Temperature_MobileTests
//
//  Created by Dev Tech on 2025/07/16.
//

import XCTest
@testable import Japan_Temperature_Mobile

// MARK: - TemperatureDataManager のテスト
class TemperatureDataManagerTests: XCTestCase {
    
    var dataManager: TemperatureDataManager!
    
    override func setUp() {
        super.setUp()
        dataManager = TemperatureDataManager()
    }
    
    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }
    
    // MARK: - 初期化テスト
    func testInitialization() {
        // Then: 正しく初期化されていることを確認
        XCTAssertEqual(dataManager.regions.count, 9)
        XCTAssertEqual(dataManager.sortOrder, .geographic)
        XCTAssertNil(dataManager.selectedRegion)
        
        // 地方名が正しく設定されているか確認
        let expectedRegions = ["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州", "沖縄"]
        let actualRegions = dataManager.regions.map { $0.name }
        XCTAssertEqual(actualRegions, expectedRegions)
    }
    
    // MARK: - 地域データの内容確認テスト
    func testRegionDataContent() {
        // Given: 初期化されたデータマネージャー
        
        // When & Then: 各地域のデータが正しく設定されているか確認
        let hokkaido = dataManager.regions.first { $0.name == "北海道" }
        XCTAssertNotNil(hokkaido)
        XCTAssertEqual(hokkaido?.temps, [18, 22, 24, 26, 20])
        XCTAssertEqual(hokkaido?.comments.count, 5)
        
        let okinawa = dataManager.regions.first { $0.name == "沖縄" }
        XCTAssertNotNil(okinawa)
        XCTAssertEqual(okinawa?.temps, [36, 38, 34, 37, 35])
        XCTAssertEqual(okinawa?.comments.count, 5)
    }
    
    // MARK: - 温度更新テスト
    func testUpdateAllTemperatures() {
        // Given: 元の温度を記録
        let originalTemps = dataManager.regions.map { $0.currentTemp }
        let originalUpdate = dataManager.lastUpdate
        
        // When: 温度を更新
        dataManager.updateAllTemperatures()
        
        // Then: 最終更新時刻が更新されていることを確認
        XCTAssertGreaterThan(dataManager.lastUpdate, originalUpdate)
        
        // 各地方の温度が候補の中から選ばれていることを確認
        for region in dataManager.regions {
            XCTAssertTrue(region.temps.contains(region.currentTemp))
            XCTAssertTrue(region.comments.contains(region.currentComment))
        }
    }
    
    // MARK: - 温度順ソートテスト
    func testSortByTemperature() {
        // Given: 温度をランダムに設定
        dataManager.updateAllTemperatures()
        
        // When: 温度順でソート
        dataManager.sortByTemperature()
        
        // Then: 温度の降順でソートされていることを確認
        let temps = dataManager.regions.map { $0.currentTemp }
        let sortedTemps = temps.sorted(by: >)
        XCTAssertEqual(temps, sortedTemps)
        XCTAssertEqual(dataManager.sortOrder, .temperature)
    }
    
    // MARK: - 地域順ソートテスト
    func testSortByRegion() {
        // Given: 温度順でソート後
        dataManager.sortByTemperature()
        
        // When: 地域順でソート
        dataManager.sortByRegion()
        
        // Then: 地理的順序でソートされていることを確認
        let expectedOrder = ["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州", "沖縄"]
        let actualOrder = dataManager.regions.map { $0.name }
        XCTAssertEqual(actualOrder, expectedOrder)
        XCTAssertEqual(dataManager.sortOrder, .geographic)
    }
    
    // MARK: - 統計情報テスト
    func testGetStats() {
        // Given: 特定の温度を設定
        dataManager.regions[0].currentTemp = 20  // 北海道
        dataManager.regions[1].currentTemp = 25  // 東北
        dataManager.regions[2].currentTemp = 30  // 関東
        dataManager.regions[3].currentTemp = 35  // 中部
        dataManager.regions[4].currentTemp = 37  // 関西 (猛暑)
        dataManager.regions[5].currentTemp = 32  // 中国
        dataManager.regions[6].currentTemp = 28  // 四国
        dataManager.regions[7].currentTemp = 38  // 九州 (猛暑)
        dataManager.regions[8].currentTemp = 36  // 沖縄 (猛暑)
        
        // When: 統計情報を取得
        let stats = dataManager.getStats()
        
        // Then: 正しく計算されていることを確認
        XCTAssertEqual(stats.average, 31)  // (20+25+30+35+37+32+28+38+36)/9 = 31
        XCTAssertEqual(stats.max, 38)      // 最高気温
        XCTAssertEqual(stats.min, 20)      // 最低気温
        XCTAssertEqual(stats.hotRegions, 3) // 36℃以上の地域数
    }
    
    // MARK: - エッジケーステスト
    func testEmptyRegionsHandling() {
        // Given: 空の地域データ
        dataManager.regions = []
        
        // When: 統計情報を取得
        let stats = dataManager.getStats()
        
        // Then: エラーが発生しないことを確認
        XCTAssertEqual(stats.average, 0)
        XCTAssertEqual(stats.max, 0)
        XCTAssertEqual(stats.min, 0)
        XCTAssertEqual(stats.hotRegions, 0)
    }
    
    // MARK: - 選択機能テスト
    func testRegionSelection() {
        // Given: 地域を選択
        let selectedRegion = dataManager.regions[0]
        
        // When: 地域を選択
        dataManager.selectedRegion = selectedRegion
        
        // Then: 正しく選択されていることを確認
        XCTAssertEqual(dataManager.selectedRegion?.name, selectedRegion.name)
        XCTAssertEqual(dataManager.selectedRegion?.currentTemp, selectedRegion.currentTemp)
    }
    
    // MARK: - 選択解除テスト
    func testRegionDeselection() {
        // Given: 地域を選択
        dataManager.selectedRegion = dataManager.regions[0]
        
        // When: 選択を解除
        dataManager.selectedRegion = nil
        
        // Then: 選択が解除されていることを確認
        XCTAssertNil(dataManager.selectedRegion)
    }
    
    // MARK: - 複数回の更新テスト
    func testMultipleUpdates() {
        // Given: 初期状態
        let initialUpdate = dataManager.lastUpdate
        
        // When: 複数回更新
        dataManager.updateAllTemperatures()
        let firstUpdate = dataManager.lastUpdate
        
        dataManager.updateAllTemperatures()
        let secondUpdate = dataManager.lastUpdate
        
        // Then: 更新時刻が順次更新されていることを確認
        XCTAssertGreaterThan(firstUpdate, initialUpdate)
        XCTAssertGreaterThan(secondUpdate, firstUpdate)
        
        // 全ての地域の温度が有効な範囲内にあることを確認
        for region in dataManager.regions {
            XCTAssertTrue(region.temps.contains(region.currentTemp))
        }
    }
    
    // MARK: - ソートの安定性テスト
    func testSortStability() {
        // Given: 同じ温度の地域を含むデータ
        dataManager.regions[0].currentTemp = 30
        dataManager.regions[1].currentTemp = 30
        dataManager.regions[2].currentTemp = 25
        
        // When: 温度順でソート
        dataManager.sortByTemperature()
        let firstSort = dataManager.regions.map { $0.name }
        
        // もう一度ソート
        dataManager.sortByTemperature()
        let secondSort = dataManager.regions.map { $0.name }
        
        // Then: 同じ結果が得られることを確認
        XCTAssertEqual(firstSort, secondSort)
    }
    
    // MARK: - 統計計算の精度テスト
    func testStatisticsAccuracy() {
        // Given: 明確な統計値を持つデータ
        let testTemps = [10, 20, 30, 40, 50, 60, 70, 80, 90]
        for (index, temp) in testTemps.enumerated() {
            if index < dataManager.regions.count {
                dataManager.regions[index].currentTemp = temp
            }
        }
        
        // When: 統計を計算
        let stats = dataManager.getStats()
        
        // Then: 正確な計算結果を確認
        XCTAssertEqual(stats.average, 50)  // (10+20+30+40+50+60+70+80+90)/9 = 50
        XCTAssertEqual(stats.max, 90)
        XCTAssertEqual(stats.min, 10)
        XCTAssertEqual(stats.hotRegions, 7)  // 36℃以上: 40,50,60,70,80,90
    }
}