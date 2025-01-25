import SwiftUI
import SpriteKit

struct SimulationTutorial: View {
    var scene: SKScene {
        let scene = TutorialSimulationScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor.clear
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene, options: [.allowsTransparency])
                .padding(30)
            VStack {
                SimulationBar()
                    .padding(.top, 30)
                Spacer()
            }
        }
    }
}

#Preview {
    SimulationView()
}
