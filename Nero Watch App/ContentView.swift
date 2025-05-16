import SwiftUI

@Observable
final class Storage {
	var stuff: [Int] {
		// get some things from local storage
		return [1, 2, 3]
	}
	
	func addStuff() {
		withMutation(keyPath: \.stuff) {
			// write some things to local storage
		}
	}
}

struct ContentView: View {
	let store: DataStore
	
	var body: some View {
		TabView {
			ParameterView(
				parameter: .salinity,
				range: 0.0..<40.0,
				store: store,
				title: "Salinity",
				unit: UnitDispersion.partsPerThousand
			)
				.containerBackground(.blue, for: .tabView)
			ParameterView(
				parameter: .nitrates,
				range: 0.0..<40.0,
				store: store,
				title: "Nitrates",
				unit: UnitDispersion.partsPerMillion
			)
				.containerBackground(.purple, for: .tabView)
			ParameterView(
				parameter: .ammonia,
				range: 0.0..<1.0,
				store: store,
				title: "Ammonia",
				unit: UnitDispersion.partsPerMillion
			)
				.containerBackground(.yellow, for: .tabView)

		}
		.tabViewStyle(.verticalPage)
	}
}

#Preview {
	ContentView(store: DataStore())
}
