//
//  JapanTemperatureMobileApp.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/07/14.
//

// App 本体（@main は1つ）
import SwiftUI

@main
struct JapanTemperatureApp: App {
    @StateObject private var vm = TemperatureViewModel(initialData: SampleData.sampleRegions)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm) // ① 環境注入（推奨）
        }
    }
}
