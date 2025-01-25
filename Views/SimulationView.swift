import SwiftUI
import SpriteKit

struct SimulationView: View {
    var scene: SKScene {
        let scene = SimulationScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = UIColor.clear
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        return scene
    }
    
    var body: some View {
        ZStack {
            HexagonGrid(segments: 9)
                .stroke(lineWidth: 3)
                .foregroundStyle(.black.opacity(0.05))
            SpriteView(scene: scene, options: [.allowsTransparency])
                .background(.clear)
            VStack {
                SimulationBar()
                    .padding(.top, 50)
                Spacer()
            }
            VStack {
                Spacer()
                SimulationMenu()
            }
        }
        .background(.white)
    }
}

#Preview {
    SimulationView()
}
