//
//  ContentView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

// MARK: - メインビュー
struct ContentView: View {
    @StateObject private var dataManager = TemperatureDataManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // ヘッダー
                HeaderView()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // 統計情報
                        StatisticsView(stats: dataManager.getStats())
                        
                        // 温度区分の凡例
                        LegendView()
                        
                        // 温度テーブル
                        TemperatureTableView(
                            regions: dataManager.regions,
                            selectedRegion: $dataManager.selectedRegion
                        )
                        
                        // コントロールボタン
                        ControlButtonsView(dataManager: dataManager)
                        
                        // 最終更新時刻
                        LastUpdateView(lastUpdate: dataManager.lastUpdate)
                        
                        // 詳細情報パネル
                        if let selectedRegion = dataManager.selectedRegion {
                            RegionDetailView(region: selectedRegion)
                        } else {
                            InstructionView()
                        }
                    }
                    .padding()
                }
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// プレビュー用
#Preview {
    ContentView()
}
