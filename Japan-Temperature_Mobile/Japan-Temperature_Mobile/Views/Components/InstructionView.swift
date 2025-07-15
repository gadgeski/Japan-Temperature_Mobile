//
//  InstructionView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("👈 地方をタップしてください")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 0.30, green: 0.69, blue: 0.31))
            
            Text("各地方の詳細情報を表示します。")
                .font(.body)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("💡 使い方:")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("• テーブルの行をタップして詳細表示")
                    Text("• 気温更新ボタンで最新情報に更新")
                    Text("• ソートボタンで並び替え")
                }
                .font(.body)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
    }
}

#Preview {
    InstructionView()
}
