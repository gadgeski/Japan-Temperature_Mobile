//
//  RegionRowView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import SwiftUI

struct RegionRowView: View {
    let region: RegionTemperature
    let apparentCelsius: Double
    let unit: TemperatureUnit
    let trend: Int

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiate

    var body: some View {
        let band = TempColorScheme.band(for: apparentCelsius)
        let bg = TempColorScheme.color(for: band, colorScheme: colorScheme, accessibility: differentiate)

        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(region.name)
                    .font(.headline)
                    .accessibilityLabel("地域: \(region.name)")

                Text("実測: " + TemperatureFormatter.display(region.temperatureC, unit: unit))
                    .font(.subheadline)
                Text("体感: " + TemperatureFormatter.display(apparentCelsius, unit: unit))
                    .font(.subheadline)
            }
            Spacer()
            trendIcon(trend)
                .font(.title3)
                .accessibilityLabel(trendAccessibilityLabel(trend))
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12).fill(bg))
        .accessibilityElement(children: .combine)
    }

    @ViewBuilder
    private func trendIcon(_ t: Int) -> some View {
        switch t {
        case 1:   Image(systemName: "arrow.up")
        case -1:  Image(systemName: "arrow.down")
        default:  Image(systemName: "minus")
        }
    }

    private func trendAccessibilityLabel(_ t: Int) -> String {
        switch t {
        case 1:  return "上昇"
        case -1: return "下降"
        default: return "変化なし"
        }
    }
}
