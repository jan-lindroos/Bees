import Foundation

struct FlowerState {
    var appearance: State
    var isTargeted = false
    
    init() {
        if Double.random(in: 0...1) < SimulationState.shared.pesticide {
            appearance = .pesticide
        } else {
            appearance = .waiting
        }
    }
    
    enum State {
        case waiting, pollinated, pesticide
    }
}
