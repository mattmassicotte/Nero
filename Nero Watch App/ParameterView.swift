import SwiftUI
import Charts

struct ParameterView: View {
	@State private var dataPoints: [ParameterDataPoint] = [
		.init(value: 33.0, date: Date(timeIntervalSinceNow: -15)),
		.init(value: 36.0, date: Date(timeIntervalSinceNow: -10)),
		.init(value: 35.0, date: Date(timeIntervalSinceNow: -5)),
		.init(value: 32.0, date: Date(timeIntervalSinceNow: 0)),
	]
	let title: String
	let value: Float
	let unit: Dimension

	var body: some View {
		NavigationStack {
			VStack {
				Text(title)
				Text(String(value))
					.font(.largeTitle)
				Text(unit.symbol)
				ParameterDataView(dataPoints: dataPoints)
					.padding(8.0)
					.frame(maxHeight: 120)
			}
			.toolbar {
				ToolbarItemGroup(placement: .bottomBar) {
					Spacer()
					Button {
						let date = dataPoints.last!.date.addingTimeInterval(5.0)
						let value = Float((30..<40).randomElement()!)
						let point = ParameterDataPoint(value: value, date: date)

						self.dataPoints.append(point)
					} label: {
						Label("Add", systemImage: "plus")
					}
				}
			}
		}
	}
}

#Preview {
	ParameterView(
		title: "Salinity",
		value: 35.0,
		unit: UnitDispersion.partsPerThousand
	)
}
