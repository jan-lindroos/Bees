import SpriteKit

class Flower: SKSpriteNode {
    var flowerState = FlowerState()
    
    init() {
        super.init(
            texture: SKTexture(imageNamed: "green.png"),
            color: .red,
            size: CGSize(width: 10, height: 10)
        )
        
        if flowerState.appearance == .pesticide {
            texture = SKTexture(imageNamed: "black.png")
        }
        
        physicsBody = SKPhysicsBody(circleOfRadius: 5)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.flower
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.none
    }
    
    func pollinate() {
        if flowerState.appearance == .pesticide {
            texture = SKTexture(imageNamed: "gray.png")
        } else {
            flowerState.appearance = .pollinated
            texture = SKTexture(imageNamed: "red.png")
        }
        SimulationState.shared.pollen += 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

