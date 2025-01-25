import SwiftUI

@Observable
class SimulationState {
    static let shared = SimulationState()
    
    var speed: CGFloat = 60
    var temperature: CGFloat = 0.0
    var pesticide: CGFloat = 0.0
    var reproduction: CGFloat = 0.5
    var survival: CGFloat = 0.7
    
    var beeCount: Int = 10
    var flowerCount: Int = 10
    var nectar: Int = 0
    var pollen: Int = 0
    var poisonCount: Int = 0
    var day: Int = 1
    
    func nextDay() {
        recalculate()
        day += 1
    }
    
    func recalculate() {
        let previousBees = beeCount
        for _ in 0..<previousBees {
            if Double.random(in: 0...1) < (1 - survival) * (SimulationState.shared.temperature / 5 + 1) {
                beeCount -= 1
            }
        }
        beeCount -= poisonCount
        for _ in 0..<nectar {
            if Double.random(in: 0...1) < reproduction {
                beeCount += 1
            }
        }
        let previousFlowers = flowerCount
        for _ in 0..<previousFlowers {
            if Double.random(in: 0...1) < (1 - survival) {
                flowerCount -= 1
            }
        }
        for _ in 0..<pollen {
            if Double.random(in: 0...1) < reproduction {
                flowerCount += 1
            }
        }
        
        nectar = 0
        pollen = 0
        poisonCount = 0
        
        if beeCount < 1 { beeCount = 1 }
        if flowerCount < 1 { flowerCount = 1 }
    }
}
