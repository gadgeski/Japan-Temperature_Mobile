//
//  DetailRow.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct DetailRow: View {
    let icon: String
    let title: String
    let content: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(icon)
                .font(.body)
            
            Text(title)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        DetailRow(icon: "☀️", title: "今日の天気:", content: "涼しく過ごしやすい")
        DetailRow(icon: "👕", title: "服装の推奨:", content: "長袖がおすすめです")
        DetailRow(icon: "🤗", title: "体感:", content: "涼しく感じます")
    }
    .padding()
}
