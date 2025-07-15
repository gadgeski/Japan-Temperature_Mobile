//
//  ControlButtonsView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

import SwiftUI

struct ControlButtonsView: View {
    @ObservedObject var dataManager: TemperatureDataManager
    
    var body: some View {
        VStack(spacing: 15) {
            Button(action: {
                dataManager.updateAllTemperatures()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("気温更新")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [Color(red: 0.30, green: 0.69, blue: 0.31), Color(red: 0.27, green: 0.63, blue: 0.29)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(25)
            }
            
            HStack(spacing: 15) {
                Button(action: {
                    dataManager.sortByTemperature()
                }) {
                    HStack {
                        Image(systemName: "flame")
                        Text("温度順")
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color(red: 0.13, green: 0.59, blue: 0.95), Color(red: 0.10, green: 0.46, blue: 0.82)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                }
                
                Button(action: {
                    dataManager.sortByRegion()
                }) {
                    HStack {
                        Image(systemName: "location")
                        Text("地域順")
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color(red: 0.13, green: 0.59, blue: 0.95), Color(red: 0.10, green: 0.46, blue: 0.82)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                }
            }
        }
    }
}

#Preview {
    ControlButtonsView(dataManager: TemperatureDataManager())
}
