//
//  LastUpdateView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct LastUpdateView: View {
    let lastUpdate: Date
    
    var body: some View {
        Text("最終更新: \(lastUpdate, formatter: dateFormatter)")
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日 HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }
}

#Preview {
    LastUpdateView(lastUpdate: Date())
}
