import SwiftUI
import Charts

extension UnitDispersion {
	public class var partsPerThousand: UnitDispersion {
		UnitDispersion(symbol: "ppt", converter: UnitConverter())
	}
}

struct ParameterDataPoint: Identifiable {
	let value: Float
	let date: Date
	let id = UUID()
}

struct ParameterView: View {
	let dataPoints: [ParameterDataPoint] = [
		.init(value: 33.0, date: Date(timeIntervalSinceNow: -15)),
		.init(value: 34.0, date: Date(timeIntervalSinceNow: -10)),
		.init(value: 35.0, date: Date(timeIntervalSinceNow: -5)),
		.init(value: 36.0, date: Date(timeIntervalSinceNow: 0)),
	]
	let title: String
	let value: Float
	let unit: Dimension

	var body: some View {
		VStack {
			Text(title)
			Text(String(value))
				.font(.largeTitle)
			Text(unit.symbol)
			Chart(dataPoints) {
				LineMark(
					x: .value("Time", $0.date),
					y: .value("Value", $0.value)
				)
				.foregroundStyle(Color.white)
			}
			.chartXAxis {
//				AxisMarks(values: .stride(by: .month)) { value in
//					AxisGridLine()
//					AxisValueLabel(format: .dateTime.month(.defaultDigits))
//				}
			}
			.chartYAxis {
//				AxisMarks(values: [30, 31, 32, 33, 34, 35, 36, 37]) {
//					AxisGridLine()
//				}
			}
			.frame(height: 120)
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
