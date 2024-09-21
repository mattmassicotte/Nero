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
				Group {
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
				}
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
