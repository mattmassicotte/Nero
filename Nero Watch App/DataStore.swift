import SwiftUI
import Empire

extension RawRepresentable where RawValue: Comparable {
	static func < (lhs: Self, rhs: Self) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}

enum Parameter: Int, IndexKeyComparable, Serializable, Deserializable {
	case salinity = 1
	case nitrates = 2
	case ammonia  = 3
	
	static let smallestRepresentableValue = Parameter.salinity
}

@IndexKeyRecord("parameter", "date")
struct DataPoint {
	let parameter: Parameter
	let date: Date
	let value: Int
}

final class DataStore {
	private let store: Store?
	
	init() {
		let url = URL
			.documentsDirectory
			.appending(path: "Nero")
		
		print("store url: ", url)
		
		do {
			try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
			
			let database = try Database(url: url)
			self.store = Store(database: database)
		} catch {
			self.store = nil
			print("unable to initialize store:", error)
		}

	}
	
	func addPoint(_ value: Float, for parameter: Parameter) {
		let point = DataPoint(parameter: parameter, date: .now, value: Int(value * 1000.0))
		
		try! store!.insert(point)
	}
	
	func points(for parameter: Parameter) -> [ParameterDataPoint] {
		let rawPoints = try! store!.withTransaction { ctx in
			try DataPoint.select(in: ctx, parameter: parameter)
		}
		
		print(parameter, rawPoints)
		
		return rawPoints.map { point in
			ParameterDataPoint(value: Float(point.value / 1000), date: point.date)
		}
	}
}
