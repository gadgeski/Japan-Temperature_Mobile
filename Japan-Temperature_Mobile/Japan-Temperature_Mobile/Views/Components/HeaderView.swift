//
//  HeaderView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("🌡️ 日本の気温マップ")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("地方別気温情報一覧")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(
            LinearGradient(
                colors: [Color(red: 0.30, green: 0.69, blue: 0.31), Color(red: 0.27, green: 0.63, blue: 0.29)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

#Preview {
    HeaderView()
}
