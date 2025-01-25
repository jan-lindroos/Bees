import Foundation

struct BeeState {
    var flower: Flower?
    var task: State = .searching
    var lastTurn: Turn = .left
    var randomTurning: Int = 0
    
    var target: CGVector {
        switch task {
        case .searching:
            if let position = flower?.position {
                return CGVector(dx: position.x, dy: position.y)
            } else { return .zero }
        default:
            return .zero
        }
    }
    
    enum State {
        case searching, returning, unsuccessful, poisoned
    }
    
    enum Turn {
        case left, right
    }
}
