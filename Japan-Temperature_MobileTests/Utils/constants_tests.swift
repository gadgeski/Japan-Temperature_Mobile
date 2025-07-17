//
//  ConstantsTests.swift
//  Japan-Temperature_MobileTests
//
//  Created by Dev Tech on 2025/07/16.
//

import XCTest
@testable import Japan_Temperature_Mobile

// MARK: - Constants のテスト
class ConstantsTests: XCTestCase {
    
    // MARK: - 地域順序テスト
    func testRegionOrder() {
        // Given & When: 地域順序の定数
        let regionOrder = AppConstants.regionOrder
        
        // Then: 正しい順序で定義されていることを確認
        XCTAssertEqual(regionOrder.count, 9)
        XCTAssertEqual(regionOrder[0], "北海道")
        XCTAssertEqual(regionOrder[1], "東北")
        XCTAssertEqual(regionOrder[2], "関東")
        XCTAssertEqual(regionOrder[3], "中部")
        XCTAssertEqual(regionOrder[4], "関西")
        XCTAssertEqual(regionOrder[5], "中国")
        XCTAssertEqual(regionOrder[6], "四国")
        XCTAssertEqual(regionOrder[7], "九州")
        XCTAssertEqual(regionOrder[8], "沖縄")
    }
    
    // MARK: - 温度閾値テスト
    func testTemperatureThresholds() {
        // Given & When: 温度閾値の定数
        let cool = AppConstants.TemperatureThresholds.cool
        let warm = AppConstants.TemperatureThresholds.warm
        let hot = AppConstants.TemperatureThresholds.hot
        
        // Then: 正しい閾値が設定されていることを確認
        XCTAssertEqual(cool, 20)
        XCTAssertEqual(warm, 28)
        XCTAssertEqual(hot, 35)
    }
    
    // MARK: - 温度閾値の論理的一貫性テスト
    func testTemperatureThresholdsLogic() {
        // Given: 温度閾値
        let cool = AppConstants.TemperatureThresholds.cool
        let warm = AppConstants.TemperatureThresholds.warm
        let hot = AppConstants.TemperatureThresholds.hot
        
        // When & Then: 論理的な順序になっていることを確認
        XCTAssertLessThan(cool, warm)
        XCTAssertLessThan(warm, hot)
        XCTAssertLessThan(cool, hot)
    }
    
    // MARK: - UI定数テスト
    func testUIConstants() {
        // Given & When: UI定数の値
        let cornerRadius = AppConstants.UI.cornerRadius
        let cardPadding = AppConstants.UI.cardPadding
        let standardSpacing = AppConstants.UI.standardSpacing
        
        // Then: 正しい値が設定されていることを確認
        XCTAssertEqual(cornerRadius, 15)
        XCTAssertEqual(cardPadding, 15)
        XCTAssertEqual(standardSpacing, 20)
    }
    
    // MARK: - UI定数の正の値テスト
    func testUIConstantsPositive() {
        // Given & When: UI定数の値
        let cornerRadius = AppConstants.UI.cornerRadius
        let cardPadding = AppConstants.UI.cardPadding
        let standardSpacing = AppConstants.UI.standardSpacing
        
        // Then: すべて正の値であることを確認
        XCTAssertGreaterThan(cornerRadius, 0)
        XCTAssertGreaterThan(cardPadding, 0)
        XCTAssertGreaterThan(standardSpacing, 0)
    }
    
    // MARK: - 地域名の重複チェックテスト
    func testRegionOrderUniqueness() {
        // Given: 地域順序配列
        let regionOrder = AppConstants.regionOrder
        
        // When: 重複を除去したセットを作成
        let uniqueRegions = Set(regionOrder)
        
        // Then: 重複がないことを確認
        XCTAssertEqual(regionOrder.count, uniqueRegions.count)
    }
    
    // MARK: - 地域名の空文字チェックテスト
    func testRegionOrderNoEmptyStrings() {
        // Given: 地域順序配列
        let regionOrder = AppConstants.regionOrder
        
        // When & Then: 空文字列が含まれていないことを確認
        for region in regionOrder {
            XCTAssertFalse(region.isEmpty)
            XCTAssertFalse(region.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }
    
    // MARK: - 定数の不変性テスト
    func testConstantsImmutability() {
        // Given & When: 定数への参照を取得
        let regionOrder1 = AppConstants.regionOrder
        let regionOrder2 = AppConstants.regionOrder
        
        // Then: 同じ参照であることを確認（定数なので）
        XCTAssertEqual(regionOrder1, regionOrder2)
        
        // 温度閾値についても同様
        XCTAssertEqual(AppConstants.TemperatureThresholds.cool, 20)
        XCTAssertEqual(AppConstants.TemperatureThresholds.warm, 28)
        XCTAssertEqual(AppConstants.TemperatureThresholds.hot, 35)
    }
    
    // MARK: - 実際の使用例テスト
    func testConstantsUsageExample() {
        // Given: 実際の使用例のような温度値
        let testTemperatures = [15, 25, 32, 38]
        
        // When & Then: 定数を使用した分類が正しく動作することを確認
        for temp in testTemperatures {
            if temp <= AppConstants.TemperatureThresholds.cool {
                XCTAssertLessThanOrEqual(temp, 20)
            } else if temp <= AppConstants.TemperatureThresholds.warm {
                XCTAssertLessThanOrEqual(temp, 28)
            } else if temp <= AppConstants.TemperatureThresholds.hot {
                XCTAssertLessThanOrEqual(temp, 35)
            } else {
                XCTAssertGreaterThan(temp, 35)
            }
        }
    }
}