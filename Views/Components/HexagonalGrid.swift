import SwiftUI

import SwiftUI

struct HexagonGrid: Shape {
    var segments: CGFloat
    
    init(segments: Int) {
        self.segments = CGFloat(segments)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let spacing = rect.width / segments
        let length = spacing / 2 / sin(.pi / 3)
        
        // draw vertical lines
        for workingHeight in stride(from: 0, through: rect.maxY, by: length * 3) {
            for startX in stride(from: spacing / 2, through: rect.maxX, by: spacing) {
                path.move(to: CGPoint(x: startX, y: workingHeight))
                path.addLine(to: CGPoint(x: startX, y: workingHeight + length))
            }
            for startX in stride (from: 0, through: rect.maxX, by: spacing) {
                path.move(to: CGPoint(x: startX, y: workingHeight + length * 1.5))
                path.addLine(to: CGPoint(x: startX, y: workingHeight + length * 2.5))
            }
        }
        
        // draw diagonals
        for workingHeight in stride(from: 1.5 * length, through: rect.maxY, by: length * 3) {
            for startX in stride(from: 0, through: rect.maxX, by: spacing) {
                path.move(to: CGPoint(x: startX, y: workingHeight))
                path.addLine(to: CGPoint(x: startX + spacing / 2, y: workingHeight - length * sin(.pi / 6)))
                path.move(to: CGPoint(x: startX + spacing / 2, y: workingHeight - length * sin(.pi / 6)))
                path.addLine(to: CGPoint(x: startX + spacing, y: workingHeight))
            }
            // This loop adjusts to start from the correct position
            let nextHeight = workingHeight + length // Adjust the next starting height correctly
            for startX in stride(from: 0, through: rect.maxX, by: spacing) {
                path.move(to: CGPoint(x: startX, y: nextHeight))
                path.addLine(to: CGPoint(x: startX + spacing / 2, y: nextHeight + length * sin(.pi / 6)))
                path.move(to: CGPoint(x: startX + spacing / 2, y: nextHeight + length * sin(.pi / 6)))
                path.addLine(to: CGPoint(x: startX + spacing, y: nextHeight))
            }
        }
        
        return path
    }
}
