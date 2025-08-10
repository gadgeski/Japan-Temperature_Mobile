//
//  TemperatureListView.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import SwiftUI

struct TemperatureListView: View {
    @StateObject var vm: TemperatureViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.regions) { r in
                    RegionRowView(
                        region: r,
                        apparentCelsius: vm.apparentCelsius(for: r),
                        unit: vm.unit,
                        trend: vm.trend(for: r.id)
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("日本の気温")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        vm.sortDescending.toggle()
                        vm.applySort()
                    } label: {
                        Image(systemName: vm.sortDescending ? "arrow.down.to.line" : "arrow.up.to.line")
                            .accessibilityLabel("並び替え")
                    }

                    Menu {
                        Picker("単位", selection: $vm.unit) {
                            Text("摂氏(℃)").tag(TemperatureUnit.celsius)
                            Text("華氏(℉)").tag(TemperatureUnit.fahrenheit)
                        }
                    } label: {
                        Image(systemName: "thermometer")
                            .accessibilityLabel("単位を変更")
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    Button {
                        withAnimation(.easeInOut) {
                            vm.updateData(newData: generateMockUpdate(from: vm.regions))
                        }
                    } label: {
                        Label("更新", systemImage: "arrow.clockwise")
                    }
                }
            }
        }
    }

    private func generateMockUpdate(from old: [RegionTemperature]) -> [RegionTemperature] {
        old.map { r in
            let delta = Double.random(in: -0.8...0.8)
            let newC = (r.temperatureC + delta).rounded(toPlaces: 1)
            let newH = (r.humidity ?? Double.random(in: 0.35...0.75))
            let newW = (r.windSpeedMS ?? Double.random(in: 0.5...5.0))
            return RegionTemperature(id: r.id, name: r.name, temperatureC: newC, humidity: newH, windSpeedMS: newW)
        }
    }
}
