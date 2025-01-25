import SpriteKit

class Hive: SKSpriteNode {
    init() {
        super.init(
            texture: SKTexture(imageNamed: "hive.png"),
            color: .orange,
            size: CGSize(width: 55, height: 50)
        )
        zPosition = 2
        
        physicsBody = SKPhysicsBody(circleOfRadius: 12)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCategory.flower
        physicsBody?.collisionBitMask = PhysicsCategory.none
        physicsBody?.contactTestBitMask = PhysicsCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
