//
//  ContentView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = TemperatureDataManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView()
                
                ScrollView {
                    VStack(spacing: 20) {
                        StatisticsView(stats: dataManager.getStats())
                        LegendView()
                        TemperatureTableView(
                            regions: dataManager.regions,
                            selectedRegion: $dataManager.selectedRegion
                        )
                        ControlButtonsView(dataManager: dataManager)
                        LastUpdateView(lastUpdate: dataManager.lastUpdate)
                        
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

#Preview {
    ContentView()
}
