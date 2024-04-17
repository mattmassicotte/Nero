import SwiftUI

extension UnitDispersion {
    public class var partsPerThousand: UnitDispersion {
        UnitDispersion(symbol: "ppt", converter: UnitConverter())
    }
}

struct ParameterView: View {
    let title: String
    let value: Float
    let unit: Dimension

    var body: some View {
        VStack {
            Text(title)
            Text(String(value))
                .font(.largeTitle)
            Text(unit.symbol)
        }
    }
}

#Preview {
    ParameterView(title: "Salinity", value: 35.0, unit: UnitDispersion.partsPerThousand)
}
