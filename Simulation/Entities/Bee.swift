import SpriteKit

class Bee: SKSpriteNode {
    var beeState: BeeState
    var updateCount: Int = 0
    
    init() {
        beeState = BeeState()
        super.init(
            texture: SKTexture(imageNamed: "yellow.png"),
            color: .orange,
            size: CGSize(width: 10, height: 10)
        )
        
        zPosition = 1
        
        physicsBody = SKPhysicsBody(circleOfRadius: 8)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.friction = 0
        physicsBody?.angularDamping = 0
        physicsBody?.linearDamping = 0
        
        let directionVector = CGVector(dx: .random(in: -1...1), dy: .random(in: -1...1))
        physicsBody?.velocity = directionVector.normalized().scaled(by: SimulationState.shared.speed)
        physicsBody?.categoryBitMask = PhysicsCategory.bee
        physicsBody?.contactTestBitMask = PhysicsCategory.flower
        physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        updateCount += 1
        if updateCount % 15 == 0 {
            let trail = Trail()
            if beeState.task == .returning {
                trail.texture = SKTexture(imageNamed: "orange.png")
            }
            trail.position = position
            parent?.addChild(trail)
        }
        
        switch beeState.task {
        case .returning:
            texture = SKTexture(imageNamed: "orange.png")
        case .searching, .unsuccessful:
            texture = SKTexture(imageNamed: "yellow.png")
        case .poisoned:
            texture = SKTexture(imageNamed: "gray.png")
        }
        
        targetFlower()
        adjustDirection()
    }
    
    func adjustDirection() {
        var maximumDeflection: CGFloat = 3
        let path = CGVector(
            dx: beeState.target.dx - self.position.x,
            dy: beeState.target.dy - self.position.y
        )
        
        if physicsBody?.velocity == .zero {
            physicsBody?.velocity = CGVector(dx: 1, dy: 1)
        }
        
        let modifier = SimulationState.shared.temperature / 5 + 1
        if beeState.randomTurning > 0 {
            beeState.randomTurning -= 1
            physicsBody?.velocity.rotate(
                angle: beeState.lastTurn == .left ? 4 * modifier : -4 * modifier
            )
        } else if Double.random(in: 0...1) > 0.98 {
            beeState.lastTurn = [BeeState.Turn.left, BeeState.Turn.right].randomElement()!
            beeState.randomTurning = Int.random(in: 10...20)
        }
        
        if let deflectionTarget = physicsBody?.velocity.angleInDegrees(to: path) {
            if abs(deflectionTarget) <= maximumDeflection {
                physicsBody?.velocity.rotate(angle: deflectionTarget)
            } else {
                if deflectionTarget < 0 {
                    maximumDeflection *= -1
                }
                physicsBody?.velocity.rotate(angle: maximumDeflection)
            }
        }
        
        physicsBody?.velocity = physicsBody!.velocity.normalized().scaled(by: SimulationState.shared.speed)
    }
    
    func enteredHive() {
        if beeState.task != .searching {
            if beeState.task == .returning {
                SimulationState.shared.nectar += 1
            }
            removeFromParent()
        }
    }
    
    func targetFlower() {
        guard beeState.flower?.flowerState.appearance == .pollinated || beeState.flower == nil else {
            return
        }
        
        guard parent != nil else { return }
        
        let allAvailableFlowers = parent!.children.filter { node in
            guard node is Flower else { return false }
            
            let flowerState = (node as! Flower).flowerState
            if flowerState.appearance != .pollinated {
                return true
            }
            return false
        }
        
        let sortedFlowers = allAvailableFlowers.sorted { node1, node2 in 
            let distance1 = sqrt(pow(node1.position.y - position.y, 2) + pow(node1.position.x - position.x, 2))
            let distance2 = sqrt(pow(node2.position.y - position.y, 2) + pow(node2.position.x - position.x, 2))
            
            return distance1 < distance2
        }
        
        if sortedFlowers.count == 0 {
            beeState.task = .unsuccessful
        } else {
            let node = sortedFlowers.dropLast(Int.random(in: 0...(sortedFlowers.count))).randomElement()
            let flower = node as! Flower?
            beeState.flower = flower
        }
    }
    
    func gotPollen(from flower: Flower) {
        if flower.flowerState.appearance == .waiting {
            beeState.task = .returning
        }
        if flower.flowerState.appearance == .pesticide {
            beeState.task = .poisoned
            SimulationState.shared.poisonCount += 1
        }
    }
}


