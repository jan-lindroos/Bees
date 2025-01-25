import SwiftUI
import Charts

struct BeehiveChart: View {
    let year: Int
    
    var body: some View {
        Chart {
            ForEach(beehiveData.dropLast(2022 - year), id: \.0) { dataPoint in
                LineMark(
                    x: .value("Year", dataPoint.0),
                    y: .value("Number of Beehives", dataPoint.1)
                )
                .foregroundStyle(.orange)
            }
        }
        .chartXScale(domain: 1960...2030)
        .chartYScale(domain: 0...6000000)
        .chartXAxisLabel("Year", position: .automatic, alignment: .center, spacing: 20)
        .chartYAxisLabel("Number of beehives", position: .trailing, alignment: .center, spacing: 20)
        .chartYAxis {
            AxisMarks(preset: .extended, position: .trailing) { value in
                if let value = value.as(Double.self) {
                    let label = String(format: "%.1fM", value / 1_000_000)
                    AxisValueLabel(label, centered: true)
                }
            }
        }
    }
}
