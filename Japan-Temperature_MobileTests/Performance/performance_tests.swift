//
//  PerformanceTests.swift
//  Japan-Temperature_MobileTests
//
//  Created by Dev Tech on 2025/07/16.
//

import XCTest
@testable import Japan_Temperature_Mobile

// MARK: - パフォーマンステスト
class PerformanceTests: XCTestCase {
    
    var dataManager: TemperatureDataManager!
    
    override func setUp() {
        super.setUp()
        dataManager = TemperatureDataManager()
    }
    
    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }
    
    // MARK: - 温度更新のパフォーマンステスト
    func testUpdateAllTemperaturesPerformance() {
        // Given: データマネージャー
        
        // When & Then: 更新処理のパフォーマンスを測定
        measure {
            dataManager.updateAllTemperatures()
        }
        
        // 期待値: 0.1秒以下での実行
        // このテストは measure {} ブロックで自動的に複数回実行され、
        // 平均実行時間が計測される
    }
    
    // MARK: - 温度順ソートのパフォーマンステスト
    func testSortByTemperaturePerformance() {
        // Given: データマネージャー
        
        // When & Then: 温度順ソート処理のパフォーマンスを測定
        measure {
            dataManager.sortByTemperature()
        }
        
        // 期待値: 0.05秒以下での実行
    }
    
    // MARK: - 地域順ソートのパフォーマンステスト
    func testSortByRegionPerformance() {
        // Given: データマネージャー
        
        // When & Then: 地域順ソート処理のパフォーマンスを測定
        measure {
            dataManager.sortByRegion()
        }
        
        // 期待値: 0.05秒以下での実行
    }
    
    // MARK: - 統計計算のパフォーマンステスト
    func testStatsCalculationPerformance() {
        // Given: データマネージャー
        
        // When & Then: 統計計算のパフォーマンスを測定
        measure {
            _ = dataManager.getStats()
        }
        
        // 期待値: 0.01秒以下での実行
    }
    
    // MARK: - 複合操作のパフォーマンステスト
    func testCombinedOperationsPerformance() {
        // Given: データマネージャー
        
        // When & Then: 複数の操作を組み合わせたパフォーマンスを測定
        measure {
            dataManager.updateAllTemperatures()
            dataManager.sortByTemperature()
            _ = dataManager.getStats()
            dataManager.sortByRegion()
        }
        
        // 期待値: 0.2秒以下での実行
    }
    
    // MARK: - 大量データの処理パフォーマンステスト
    func testLargeDatasetPerformance() {
        // Given: 大量のデータを持つダミーの地域配列を作成
        var largeRegions: [RegionData] = []
        for i in 0..<1000 {
            largeRegions.append(RegionData(
                name: "地域\(i)",
                temps: Array(20...40),
                comments: ["コメント1", "コメント2", "コメント3"]
            ))
        }
        
        // テスト用の一時的なデータマネージャーを作成
        let testDataManager = TemperatureDataManager()
        testDataManager.regions = largeRegions
        
        // When & Then: 大量データでの統計計算パフォーマンスを測定
        measure {
            _ = testDataManager.getStats()
        }
        
        // 期待値: 1000件のデータでも0.1秒以下での実行
    }
    
    // MARK: - 繰り返し処理のパフォーマンステスト
    func testRepeatedOperationsPerformance() {
        // Given: データマネージャー
        
        // When & Then: 繰り返し処理のパフォーマンスを測定
        measure {
            for _ in 0..<100 {
                dataManager.updateAllTemperatures()
                _ = dataManager.getStats()
            }
        }
        
        // 期待値: 100回の繰り返しでも2秒以下での実行
    }
    
    // MARK: - メモリ効率のテスト
    func testMemoryEfficiency() {
        // Given: データマネージャー
        
        // When & Then: メモリ使用量を意識した処理のパフォーマンスを測定
        measure {
            // 大量のオブジェクトを作成・破棄
            for _ in 0..<1000 {
                let tempRegion = RegionData(
                    name: "Temp",
                    temps: [20, 25, 30],
                    comments: ["Test"]
                )
                _ = tempRegion.statusText
                _ = tempRegion.temperatureColor
                _ = tempRegion.recommendation
            }
        }
        
        // 期待値: メモリリークなしでの効率的な実行
    }
    
    // MARK: - 初期化パフォーマンステスト
    func testInitializationPerformance() {
        // When & Then: データマネージャーの初期化パフォーマンスを測定
        measure {
            _ = TemperatureDataManager()
        }
        
        // 期待値: 0.01秒以下での初期化
    }
    
    // MARK: - Extension機能のパフォーマンステスト
    func testExtensionMethodsPerformance() {
        // Given: 地域データ
        let region = dataManager.regions[0]
        
        // When & Then: Extension機能のパフォーマンスを測定
        measure {
            for _ in 0..<1000 {
                _ = region.statusText
                _ = region.statusEmoji
                _ = region.feelsLike
                _ = region.recommendation
                _ = region.healthAdvice
                _ = region.temperatureColor
                _ = region.temperatureGradient
            }
        }
        
        // 期待値: 1000回の呼び出しでも0.1秒以下での実行
    }
    
    // MARK: - 並行処理のパフォーマンステスト
    func testConcurrentOperationsPerformance() {
        // Given: 複数のデータマネージャー
        let dataManagers = (0..<10).map { _ in TemperatureDataManager() }
        
        // When & Then: 並行処理のパフォーマンスを測定
        measure {
            let expectation = self.expectation(description: "Concurrent operations")
            expectation.expectedFulfillmentCount = dataManagers.count
            
            for dataManager in dataManagers {
                DispatchQueue.global(qos: .userInitiated).async {
                    dataManager.updateAllTemperatures()
                    dataManager.sortByTemperature()
                    _ = dataManager.getStats()
                    expectation.fulfill()
                }
            }
            
            wait(for: [expectation], timeout: 5.0)
        }
        
        // 期待値: 10個の並行処理でも5秒以下での実行
    }
    
    // MARK: - 最悪ケースのパフォーマンステスト
    func testWorstCasePerformance() {
        // Given: 最悪ケースのシナリオ
        // 全ての地域が同じ温度（ソートが困難）
        for i in 0..<dataManager.regions.count {
            dataManager.regions[i].currentTemp = 30
        }
        
        // When & Then: 最悪ケースでのパフォーマンスを測定
        measure {
            dataManager.sortByTemperature()
            dataManager.sortByRegion()
            _ = dataManager.getStats()
        }
        
        // 期待値: 最悪ケースでも0.1秒以下での実行
    }
}