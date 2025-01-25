import SwiftUI

struct ContentView: View {
    @State var showSimulation = false
    
    var body: some View {
        ZStack {
            if showSimulation {
                SimulationView()
            }
            if !showSimulation {
                LearningView(showSimulation: $showSimulation)
                    .transition(.opacity)
                OnboardingView()
            }
        }
        .ignoresSafeArea()
    }
}
