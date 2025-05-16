import SwiftUI

enum MeasurementStep {
	case start
	case numeric
}

struct ParameterDetails {
	var range: Range<Float>
	var lastValue: Float
}

struct MeasurementStepView: View {
	@State private var value: Float = 0.0
	
	let range: Range<Float>
	let saveAction: (Float) -> Void
	
	init(range: Range<Float>, saveAction: @escaping (Float) -> Void) {
		self.range = range
		self.saveAction = saveAction
	}

	var body: some View {
		Text("Scroll: \(value)")
			.focusable(true)
			.digitalCrownRotation(
				$value,
				from: range.lowerBound,
				through: range.upperBound,
				by: 0.1,
				sensitivity: .low,
				isContinuous: true,
				isHapticFeedbackEnabled: true
			)
		Button("Save") {
			saveAction(value)
		}
	}
}

struct MeasurementView: View {
	@State private var presentedSteps: [MeasurementStep] = []
	
	let range: Range<Float>
	let saveAction: (Float) -> Void
	
	private var currentStep: MeasurementStep {
		presentedSteps.last ?? .start
	}

    var body: some View {
		NavigationStack(path: $presentedSteps) {
			Text("at step: \(currentStep)")
				.navigationDestination(for: MeasurementStep.self) { step in
					MeasurementStepView(range: range, saveAction: saveAction)
				}
		}
    }
}

#Preview {
	MeasurementView(range: 0.0..<1.0, saveAction: { _ in })
}
