import SpriteKit

class Trail: SKSpriteNode {
    init() {
        super.init(
            texture: SKTexture(imageNamed: "yellow.png"),
            color: .orange,
            size: CGSize(width: 5, height: 5)
        )
        zPosition = -2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decay() {
        if self.alpha > 0 {
            self.alpha -= 0.0025
        } else {
            self.removeFromParent()
        }
    }
}
