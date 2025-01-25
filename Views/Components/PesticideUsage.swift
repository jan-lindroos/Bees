import SwiftUI
import Charts

struct PesticideChart: View {
    let year: Int
    let data: [(String, Int, Double)] = pesticideData
    
    var filteredDataForYear: [PesticideUsage] {
        data.filter { $0.1 == year }
            .map { PesticideUsage(country: $0.0, usage: $0.2) }
    }
    
    var body: some View {
        Chart {
            ForEach(filteredDataForYear) { usage in
                BarMark(
                    x: .value("Country", usage.country),
                    y: .value("Pesticide Usage (Tonnes)", usage.usage)
                )
                .foregroundStyle(.orange)
            }
        }
        .chartXAxisLabel("Year", position: .automatic, alignment: .center, spacing: 20)
        .chartYAxisLabel("Pesticide usage (agriculture)", position: .trailing, alignment: .center, spacing: 20)
        .chartYScale(domain: 0...600000)
    }
}

struct PesticideUsage: Identifiable {
    let id = UUID()
    let country: String
    let usage: Double
}

