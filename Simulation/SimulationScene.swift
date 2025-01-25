import SpriteKit

class SimulationScene: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        addChild(Hive())
        loadNextDay()
    }
    
    override func update(_ currentTime: TimeInterval) {
        var beeCount = 0
        children.forEach { child in
            if child is Bee {
                beeCount += 1
                (child as! Bee).update()
            } else if child is Trail {
                (child as! Trail).decay()
            }
        }
        if beeCount == 0 {
            let state = SimulationState.shared
            state.nextDay()
            loadNextDay()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        guard bodyA.node != nil && bodyB.node != nil else { return }
        
        if bodyA.categoryBitMask == PhysicsCategory.bee && bodyB.categoryBitMask == PhysicsCategory.flower ||
            bodyA.categoryBitMask == PhysicsCategory.flower && bodyB.categoryBitMask == PhysicsCategory.bee {
            if bodyA.node! is Bee {
                if bodyB.node! is Flower {
                    let flower = bodyB.node! as! Flower
                    let bee = bodyA.node! as! Bee
                    if bee.beeState.flower == flower {
                        bee.gotPollen(from: flower)
                        flower.pollinate()
                    }
                }
                if bodyB.node! is Hive {
                    (bodyA.node! as! Bee).enteredHive()
                }
            } else if bodyB.node! is Bee {
                if bodyA.node! is Flower {
                    let flower = bodyA.node! as! Flower
                    let bee = bodyB.node! as! Bee
                    if bee.beeState.flower == flower {
                        bee.gotPollen(from: flower)
                        flower.pollinate()
                    }
                }
                if bodyA.node! is Hive {
                    (bodyB.node! as! Bee).enteredHive()
                }
            }
        }
    }
    
    func loadNextDay() {
        let state = SimulationState.shared
        
        children.forEach { child in
            if child is Flower {
                child.removeFromParent()
            }
        }
        
        for _ in 0..<state.flowerCount {
            let flower = Flower()
            flower.position = CGPoint(
                x: .random(in: (-size.width / 2.3)...(size.width / 2.3)),
                y: .random(in: (-size.height / 2.3)...(size.height / 2.3))
            )
            addChild(flower)
        }
        
        for _ in 0..<state.beeCount {
            let bee = Bee()
            bee.position = .zero
            addChild(bee)
            bee.targetFlower()
        }
    }
}

