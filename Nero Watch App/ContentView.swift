//
//  ContentView.swift
//  Nero Watch App
//
//  Created by Matthew Massicotte on 2024-04-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("A")
                .containerBackground(.green, for: .tabView)
            Text("B")
                .containerBackground(.blue, for: .tabView)
            Text("C")
                .containerBackground(.red, for: .tabView)
        }
        .tabViewStyle(.verticalPage)
    }
}

#Preview {
    ContentView()
}
