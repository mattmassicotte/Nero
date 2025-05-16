import SwiftUI
import Charts

struct ParameterDetailView: View {
	let dataPoints: [ParameterDataPoint]
	let title: String
	let unit: Dimension

	var body: some View {
		VStack {
			Text(title)
			Text(String(latestValue))
				.font(.largeTitle)
			Text(unit.symbol)
			ParameterDataView(dataPoints: dataPoints)
				.padding(8.0)
				.frame(maxHeight: 120)
		}
	}
	
	var latestValue: Float {
		dataPoints.last?.value ?? 0.0
	}
}

struct ParameterView: View {
	@State private var presentedSteps: [MeasurementStep] = []
	@State private var dataPoints: [ParameterDataPoint] = []
	
	let parameter: Parameter
	let range: Range<Float>
	let store: DataStore
	let title: String
	let unit: Dimension

	var body: some View {
		NavigationStack(path: $presentedSteps) {
			ParameterDetailView(dataPoints: dataPoints, title: title, unit: unit)
				.toolbar {
					ToolbarItemGroup(placement: .bottomBar) {
						Spacer()
						Button {
							self.presentedSteps.append(.start)
						} label: {
							Label("Add", systemImage: "plus")
						}
					}
				}
				.toolbar(toolbarVisible, for: .bottomBar)
				.navigationDestination(for: MeasurementStep.self) { step in
					MeasurementStepView(range: range) { value in
						store.addPoint(value, for: parameter)
						loadPoints()
						self.presentedSteps = []
					}
				}
		}
		.onAppear {
			loadPoints()
		}
	}

	private var toolbarVisible: Visibility {
		(presentedSteps.last == nil) ? .automatic : .hidden
	}
	
	private func loadPoints() {
		self.dataPoints = store.points(for: parameter)
	}
}

#Preview {
	ParameterView(
		parameter: .salinity,
		range: 0.0..<40.0,
		store: DataStore(),
		title: "Salinity",
		unit: UnitDispersion.partsPerThousand
	)
}
