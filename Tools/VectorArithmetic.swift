import Foundation

extension CGVector {
    mutating func rotate(angle: CGFloat) {
        let radians = angle * .pi / 180
        
        self.dx = self.dx * cos(radians) - self.dy * sin(radians)
        self.dy = self.dx * sin(radians) + self.dy * cos(radians)
    }
    
    func length() -> CGFloat {
        return sqrt(dx * dx + dy * dy)
    }
    
    func dot(_ vector: CGVector) -> CGFloat {
        return dx * vector.dx + dy * vector.dy
    }
    
    func cross(_ vector: CGVector) -> CGFloat {
        return dx * vector.dy - dy * vector.dx
    }
    
    func angle(to vector: CGVector) -> CGFloat {
        let dotProd = self.dot(vector)
        let lenProd = self.length() * vector.length()
        let div = dotProd / lenProd
        let angle = acos(min(max(div, -1.0), 1.0))
        
        let crossProd = self.cross(vector)
        return crossProd > 0 ? angle : -angle
    }
    
    func angleInDegrees(to vector: CGVector) -> CGFloat {
        return angle(to: vector) * 180 / .pi
    }
    
    func normalized() -> CGVector {
        let len = self.length()
        return len > 0 ? CGVector(dx: dx / len, dy: dy / len) : CGVector.zero
    }
    
    func scaled(by scalar: CGFloat) -> CGVector {
        return CGVector(dx: dx * scalar, dy: dy * scalar)
    }
    
    func magnitude() -> CGFloat {
        return sqrt(dy * dy + dx * dx)
    }
}
