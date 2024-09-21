import SwiftUI
import Charts

struct ParameterDataPoint: Identifiable {
	let value: Float
	let date: Date
	let id = UUID()
}

struct ParameterDataView: View {
	let dataPoints: [ParameterDataPoint]

    var body: some View {
		Chart(dataPoints) {
			LineMark(
				x: .value("Time", $0.date),
				y: .value("Value", $0.value)
			)
			.foregroundStyle(Color.white)
			.symbol {
				Circle()
					.fill(Color.white)
					.frame(width: 6, height: 6)
			}
		}
		.chartXAxis {}
		.chartYAxis {}
    }
}

#Preview {
	ParameterDataView(dataPoints: [])
}
