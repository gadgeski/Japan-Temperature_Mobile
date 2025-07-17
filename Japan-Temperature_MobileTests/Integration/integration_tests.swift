//
//  IntegrationTests.swift
//  Japan-Temperature_MobileTests
//
//  Created by Dev Tech on 2025/07/16.
//

import XCTest
@testable import Japan_Temperature_Mobile

// MARK: - 統合テスト
class IntegrationTests: XCTestCase {
    
    var dataManager: TemperatureDataManager!
    
    override func setUp() {
        super.setUp()
        dataManager = TemperatureDataManager()
    }
    
    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }
    
    // MARK: - 完全なワークフローテスト
    func testCompleteWorkflow() {
        // Given: データマネージャー
        
        // When: 完全なワークフローを実行
        // 1. 温度更新
        dataManager.updateAllTemperatures()
        
        // 2. 温度順ソート
        dataManager.sortByTemperature()
        
        // 3. 統計情報取得
        let stats1 = dataManager.getStats()
        
        // 4. 地域順ソート
        dataManager.sortByRegion()
        
        // 5. 再度統計情報取得
        let stats2 = dataManager.getStats()
        
        // 6. 地域選択
        dataManager.selectedRegion = dataManager.regions[0]
        
        // Then: 全ての操作が正常に完了することを確認
        XCTAssertNotNil(stats1)
        XCTAssertNotNil(stats2)
        XCTAssertEqual(stats1.average, stats2.average) // ソートしても統計は変わらない
        XCTAssertEqual(stats1.max, stats2.max)
        XCTAssertEqual(stats1.min, stats2.min)
        XCTAssertEqual(stats1.hotRegions, stats2.hotRegions)
        XCTAssertNotNil(dataManager.selectedRegion)
        XCTAssertEqual(dataManager.regions.count, 9)
    }
    
    // MARK: - データの一貫性テスト
    func testDataConsistency() {
        // Given: 初期化されたデータマネージャー
        
        // When: 複数回の操作を実行
        for _ in 0..<5 {
            dataManager.updateAllTemperatures()
            dataManager.sortByTemperature()
            dataManager.sortByRegion()
        }
        
        // Then: データの一貫性が保たれていることを確認
        XCTAssertEqual(dataManager.regions.count, 9)
        
        // 地域名が正しく保持されていることを確認
        let expectedRegions = AppConstants.regionOrder
        let actualRegions = dataManager.regions.map { $0.name }
        XCTAssertEqual(actualRegions, expectedRegions)
        
        // 全ての地域の温度が有効な範囲内にあることを確認
        for region in dataManager.regions {
            XCTAssertTrue(region.temps.contains(region.currentTemp))
            XCTAssertTrue(region.comments.contains(region.currentComment))
        }
    }
    
    // MARK: - ユーザーインタラクションシミュレーション
    func testUserInteractionSimulation() {
        // Given: ユーザーの典型的な操作をシミュレート
        
        // When: ユーザーが画面を開く
        let initialStats = dataManager.getStats()
        XCTAssertNotNil(initialStats)
        
        // ユーザーが地域を選択
        dataManager.selectedRegion = dataManager.regions[0]
        let selectedRegion = dataManager.selectedRegion
        XCTAssertNotNil(selectedRegion)
        
        // ユーザーが気温更新ボタンを押す
        let oldTemp = selectedRegion?.currentTemp
        dataManager.updateAllTemperatures()
        let newStats = dataManager.getStats()
        
        // ユーザーが温度順ソートボタンを押す
        dataManager.sortByTemperature()
        XCTAssertEqual(dataManager.sortOrder, .temperature)
        
        // ユーザーが地域順ソートボタンを押す
        dataManager.sortByRegion()
        XCTAssertEqual(dataManager.sortOrder, .geographic)
        
        // ユーザーが別の地域を選択
        dataManager.selectedRegion = dataManager.regions[1]
        
        // Then: 全ての操作が正常に動作することを確認
        XCTAssertNotNil(newStats)
        XCTAssertEqual(dataManager.selectedRegion?.name, dataManager.regions[1].name)
        XCTAssertEqual(dataManager.regions.count, 9)
    }
    
    // MARK: - エラー耐性テスト
    func testErrorResilience() {
        // Given: 異常な状態をシミュレート
        
        // When: 空の地域配列でも動作するかテスト
        let originalRegions = dataManager.regions
        dataManager.regions = []
        
        let emptyStats = dataManager.getStats()
        XCTAssertNotNil(emptyStats)
        XCTAssertEqual(emptyStats.average, 0)
        
        // 地域配列を復元
        dataManager.regions = originalRegions
        
        // 選択された地域が存在しない場合のテスト
        dataManager.selectedRegion = RegionData(name: "存在しない地域", temps: [25], comments: ["テスト"])
        XCTAssertNotNil(dataManager.selectedRegion)
        
        // Then: エラーが発生せず、適切にハンドリングされることを確認
        let finalStats = dataManager.getStats()
        XCTAssertNotNil(finalStats)
        XCTAssertEqual(dataManager.regions.count, 9)
    }
    
    // MARK: - パフォーマンスと状態の整合性テスト
    func testPerformanceAndStateConsistency() {
        // Given: 大量の操作をシミュレート
        
        // When: 連続した操作を実行
        for i in 0..<100 {
            dataManager.updateAllTemperatures()
            
            if i % 2 == 0 {
                dataManager.sortByTemperature()
            } else {
                dataManager.sortByRegion()
            }
            
            if i % 5 == 0 {
                dataManager.selectedRegion = dataManager.regions[i % 9]
            }
            
            let stats = dataManager.getStats()
            
            // Then: 各操作後に状態が一貫していることを確認
            XCTAssertNotNil(stats)
            XCTAssertEqual(dataManager.regions.count, 9)
            XCTAssertGreaterThanOrEqual(stats.average, 0)
            XCTAssertGreaterThanOrEqual(stats.max, stats.min)
            XCTAssertGreaterThanOrEqual(stats.hotRegions, 0)
        }
    }
    
    // MARK: - RegionDataとExtensionsの統合テスト
    func testRegionDataIntegration() {
        // Given: データマネージャーの地域データ
        let region = dataManager.regions[0]
        
        // When: 地域データとExtensionsの機能を組み合わせて使用
        let originalTemp = region.currentTemp
        let statusText = region.statusText
        let statusEmoji = region.statusEmoji
        let recommendation = region.recommendation
        let healthAdvice = region.healthAdvice
        
        // 温度を更新
        dataManager.updateAllTemperatures()
        let updatedRegion = dataManager.regions[0]
        
        // Then: Extensions機能が正しく動作することを確認
        XCTAssertNotNil(statusText)
        XCTAssertNotNil(statusEmoji)
        XCTAssertNotNil(recommendation)
        XCTAssertNotNil(healthAdvice)
        
        // 更新後も正しく動作することを確認
        XCTAssertNotNil(updatedRegion.statusText)
        XCTAssertNotNil(updatedRegion.statusEmoji)
        XCTAssertNotNil(updatedRegion.recommendation)
        XCTAssertNotNil(updatedRegion.healthAdvice)
        
        // 温度に応じた適切な値が設定されていることを確認
        XCTAssertTrue(updatedRegion.temps.contains(updatedRegion.currentTemp))
        XCTAssertTrue(updatedRegion.comments.contains(updatedRegion.currentComment))
    }
    
    // MARK: - 統計情報とデータ管理の統合テスト
    func testStatisticsIntegration() {
        // Given: 特定の温度設定でテスト
        dataManager.regions[0].currentTemp = 18  // 涼しい
        dataManager.regions[1].currentTemp = 25  // 暖かい
        dataManager.regions[2].currentTemp = 32  // 暑い
        dataManager.regions[3].currentTemp = 37  // 猛暑
        dataManager.regions[4].currentTemp = 39  // 猛暑
        dataManager.regions[5].currentTemp = 30  // 暑い
        dataManager.regions[6].currentTemp = 28  // 暖かい
        dataManager.regions[7].currentTemp = 35  // 暑い
        dataManager.regions[8].currentTemp = 40  // 猛暑
        
        // When: 統計情報を取得
        let stats = dataManager.getStats()
        
        // Then: 統計情報が正確に計算されていることを確認
        let expectedAverage = (18 + 25 + 32 + 37 + 39 + 30 + 28 + 35 + 40) / 9
        XCTAssertEqual(stats.average, expectedAverage)
        XCTAssertEqual(stats.max, 40)
        XCTAssertEqual(stats.min, 18)
        XCTAssertEqual(stats.hotRegions, 3)  // 37, 39, 40 (36℃以上)
        
        // 各地域のExtensions機能も正しく動作することを確認
        XCTAssertEqual(dataManager.regions[0].statusText, "涼しい")  // 18℃
        XCTAssertEqual(dataManager.regions[1].statusText, "暖かい")  // 25℃
        XCTAssertEqual(dataManager.regions[2].statusText, "暑い")   // 32℃
        XCTAssertEqual(dataManager.regions[3].statusText, "猛暑")   // 37℃
    }
}