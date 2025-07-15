//
//  TemperatureTableView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct TemperatureTableView: View {
    let regions: [RegionData]
    @Binding var selectedRegion: RegionData?
    
    var body: some View {
        VStack(spacing: 0) {
            // テーブルヘッダー
            HStack {
                Text("地方")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("現在気温")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                
                Text("状態")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                
                Text("体感")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [Color(red: 0.30, green: 0.69, blue: 0.31), Color(red: 0.27, green: 0.63, blue: 0.29)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            
            // テーブル内容
            VStack(spacing: 0) {
                ForEach(regions, id: \.name) { region in
                    TemperatureRowView(
                        region: region,
                        isSelected: selectedRegion?.name == region.name
                    )
                    .onTapGesture {
                        selectedRegion = region
                    }
                }
            }
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

#Preview {
    @Previewable @State var selectedRegion: RegionData? = nil
    let sampleRegions = [
        RegionData(name: "北海道", temps: [18, 22, 24, 26, 20], comments: ["涼しく過ごしやすい", "散歩日和"]),
        RegionData(name: "関東", temps: [32, 34, 30, 33, 31], comments: ["暑い一日", "熱中症注意"])
    ]
    
    return TemperatureTableView(regions: sampleRegions, selectedRegion: $selectedRegion)
}
