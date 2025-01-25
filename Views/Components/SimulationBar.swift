import SwiftUI

struct SimulationBar: View {
    var simulation = SimulationState.shared
    
    var body: some View {
        HStack(spacing: 20) {
            Text("Day \(simulation.day)")
                .fontWeight(.semibold)    
                .padding()
                .frame(height: 40)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("\(simulation.beeCount) 🐝")
                .fontWeight(.semibold)
                .padding()
                .frame(height: 40)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("\(simulation.flowerCount) 🌸")
                .fontWeight(.semibold)
                .padding()
                .frame(height: 40)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.top)
    }
}
