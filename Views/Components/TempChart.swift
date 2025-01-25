import SwiftUI
import Charts

struct TempChart: View {
    let year: Int
    
    var dataSeries1: [DataPoint] {
        tempData.map { DataPoint(year: $0.0, value: $0.1) }
    }
    
    var dataSeries2: [DataPoint] {
        tempData.map { DataPoint(year: $0.0, value: $0.2) }
    }
    
    var body: some View {
        Chart {
            ForEach(dataSeries1.dropLast(2023 - year)) { dataPoint in
                LineMark(
                    x: .value("Year", dataPoint.year),
                    y: .value("Actual temperature", dataPoint.value),
                    series: .value("Temperature", "Actual")
                )
                .foregroundStyle(.orange)
            }
            
            ForEach(dataSeries2.dropLast(2023 - year)) { dataPoint in
                LineMark(
                    x: .value("Year", dataPoint.year),
                    y: .value("Smoothed temperature", dataPoint.value),
                    series: .value("Temperature", "Smoothed")
                )
                .foregroundStyle(.black)
            }
        }
        .chartXAxisLabel("Year", position: .automatic, alignment: .center, spacing: 20)
        .chartYAxisLabel("Temperature change", position: .trailing, alignment: .center, spacing: 20)
        .chartXScale(domain: 1880...2023)
        .chartYScale(domain: -1...2)
    }
}

struct DataPoint: Identifiable {
    let id = UUID()
    let year: Int
    let value: Double
}

