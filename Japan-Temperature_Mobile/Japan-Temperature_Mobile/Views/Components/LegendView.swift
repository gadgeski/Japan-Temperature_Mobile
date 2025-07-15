//
//  LegendView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct LegendView: View {
    let legendItems = [
        (color: LinearGradient(colors: [Color(red: 0.31, green: 0.76, blue: 0.97), Color(red: 0.16, green: 0.71, blue: 0.96)], startPoint: .leading, endPoint: .trailing), text: "涼しい (20℃以下)"),
        (color: LinearGradient(colors: [Color(red: 1.0, green: 0.72, blue: 0.30), Color(red: 1.0, green: 0.60, blue: 0.0)], startPoint: .leading, endPoint: .trailing), text: "暖かい (21-28℃)"),
        (color: LinearGradient(colors: [Color(red: 1.0, green: 0.44, blue: 0.26), Color(red: 0.96, green: 0.26, blue: 0.21)], startPoint: .leading, endPoint: .trailing), text: "暑い (29-35℃)"),
        (color: LinearGradient(colors: [Color(red: 0.91, green: 0.12, blue: 0.39), Color(red: 0.76, green: 0.10, blue: 0.36)], startPoint: .leading, endPoint: .trailing), text: "非常に暑い (36℃以上)")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("🌡️ 温度区分")
                    .font(.headline)
                    .foregroundColor(Color(red: 0.30, green: 0.69, blue: 0.31))
                Spacer()
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                ForEach(0..<legendItems.count, id: \.self) { index in
                    HStack(spacing: 10) {
                        Circle()
                            .fill(legendItems[index].color)
                            .frame(width: 20, height: 20)
                        
                        Text(legendItems[index].text)
                            .font(.caption)
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
    }
}

#Preview {
    LegendView()
}
