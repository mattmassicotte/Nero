import SwiftUI

struct ContentView: View {
	var body: some View {
		TabView {
			ParameterView(title: "Salinity", value: 35.0, unit: UnitDispersion.partsPerThousand)
				.containerBackground(.blue, for: .tabView)
			ParameterView(title: "Nitrates", value: 30.8, unit: UnitDispersion.partsPerMillion)
				.containerBackground(.purple, for: .tabView)
			ParameterView(title: "Ammonia", value: 0.4, unit: UnitDispersion.partsPerMillion)
				.containerBackground(.yellow, for: .tabView)

		}
		.tabViewStyle(.verticalPage)
	}
}

#Preview {
	ContentView()
}
