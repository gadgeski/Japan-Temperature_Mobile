//
//  TemperatureRowView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct TemperatureRowView: View {
    let region: RegionData
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(region.name)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(region.currentTemp)℃")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 70, height: 35)
                .background(region.temperatureGradient)
                .cornerRadius(18)
            
            Text(region.statusText)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(region.temperatureColor)
                .cornerRadius(12)
                .frame(maxWidth: .infinity)
            
            Text(region.feelsLike)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(isSelected ? Color(red: 0.91, green: 0.96, blue: 0.91) : Color.clear)
        .overlay(
            Rectangle()
                .fill(isSelected ? Color(red: 0.30, green: 0.69, blue: 0.31) : Color.clear)
                .frame(width: 4)
                .clipped(),
            alignment: .leading
        )
    }
}

#Preview {
    let sampleRegion = RegionData(name: "北海道", temps: [18, 22, 24, 26, 20], comments: ["涼しく過ごしやすい", "散歩日和"])
    
    return VStack {
        TemperatureRowView(region: sampleRegion, isSelected: false)
        TemperatureRowView(region: sampleRegion, isSelected: true)
    }
}
