import SwiftUI

import SwiftUI

@Observable class OnboardingState {
    let horizontalSegments = 9
    var emphasiseTapping = false
    var phase: Phase = .Presenting
    var showText = true
    var showBackground = true
    
    enum Phase {
        case Presenting, Transition, Hidden
    }
    
    var mainGridWidth: CGFloat {
        switch phase {
        case .Presenting: 3
        case .Transition: 20
        case .Hidden: 0
        }
    }
    
    var mainGridStyle: Color {
        switch phase {
        case .Presenting: .black.opacity(0.05)
        case .Transition: .orange
        case .Hidden: .orange
        }
    }
    
    var secondaryGridWidth: CGFloat {
        switch phase {
        case .Presenting: 3
        case .Transition: 150
        case .Hidden: 0
        }
    }
    
    var secondaryGridStyle: Color {
        switch phase {
        case .Presenting: .yellow.opacity(0)
        case .Transition: .yellow
        case .Hidden: .yellow
        }
    }
    
    func tap() {
        guard phase == .Presenting else { return }
        
        withAnimation(.linear(duration: 0.3)) {
            showText = false
        }
        withAnimation(.easeIn(duration: 0.8)) {
            phase = .Transition
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.showBackground = false
            withAnimation(.easeIn(duration: 0.8)) {
                self.phase = .Hidden
            }
        }
    }
}

struct OnboardingView: View {
    var state = OnboardingState()
    
    var body: some View {
        ZStack {
            if state.showBackground {
                Color.white
            }
            HexagonGrid(segments: state.horizontalSegments)
                .stroke(lineWidth: state.secondaryGridWidth)
                .foregroundStyle(state.secondaryGridStyle)
            HexagonGrid(segments: state.horizontalSegments)
                .stroke(lineWidth: state.mainGridWidth)
                .foregroundStyle(state.mainGridStyle)
            VStack(spacing: 10) {
                Text("Bees 🐝")
                    .font(.system(size: 70))
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Text("and why they matter.")
                    .font(.system(size: 30))
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
            .offset(y: state.showText ? 0 : -UIScreen.main.bounds.height)
            VStack {
                    Spacer()
                    Text("Tap anywhere to begin.")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .foregroundStyle(.black.opacity(1))
                        .scaleEffect(
                            state.emphasiseTapping ? CGSize(width: 0.95, height: 0.95) : CGSize(width: 1, height: 1)
                        )
                        .animation(
                            .easeInOut(duration: 0.75).repeatForever(autoreverses: true),
                            value: state.emphasiseTapping
                        )
                        .padding(.bottom, 40)
            }
            .offset(y: state.showText ? 0 : UIScreen.main.bounds.height)
        }
        .onAppear {
            state.emphasiseTapping = true
        }
        .onTapGesture {
            state.tap()
        }
    }
}

#Preview {
    OnboardingView()
}

