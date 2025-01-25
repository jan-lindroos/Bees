import SwiftUI

@Observable class LearningState {
    var currentChapter: Chapter = .Chapter1
    var stage = 0
    
    var beehiveYear: Double = 1961
    var pesticideYear: Double = 1990
    var temperatureYear: Double = 1880
    var speed: Double = 1
    var pesticide: Double = 0
    var temperature: Double = 0
    
    enum Chapter {
        case Chapter1, Chapter2, Chapter3
    }
    
    var chapter: String {
        switch currentChapter {
        case .Chapter1: "CHAPTER 1"
        case .Chapter2: "CHAPTER 2"
        case .Chapter3: "CHAPTER 3"
        }
    }
    
    var chapterTitle: String {
        switch currentChapter {
        case .Chapter1: "Bees are remarkable 🐝"
        case .Chapter2: "Pesticides and climate change 🏜️"
        case .Chapter3: "Simulating a bee colony 📡"
        }
    }
    
    func next() { 
        stage += 1
        if stage > 2 {
            switch currentChapter {
            case .Chapter1:
                stage = 0
                currentChapter = .Chapter2
            case .Chapter2:
                stage = 0
                currentChapter = .Chapter3
            case .Chapter3:
                currentChapter = .Chapter3
            }
        }
    }
    
    func previous() {
        switch currentChapter {
        case .Chapter1:
            print()
        case .Chapter2:
            currentChapter = .Chapter1
        case .Chapter3:
            if stage == 0 {
                currentChapter = .Chapter2
            } else {
                stage -= 1
            }
        }
    }
}

struct LearningView: View {
    @Binding var showSimulation: Bool
    
    var state = LearningState()
    
    var body: some View {
        GeometryReader { geometry in 
            HStack {
                VStack(alignment: .leading) {
                    Text(state.chapter)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .opacity(0.3)
                        .padding(.top, 50)
                        .padding(.bottom, 1)
                    Text(state.chapterTitle)
                        .font(.title)
                        .bold()
                        .fontDesign(.rounded)
                        .padding(.bottom, 30)
                    switch state.currentChapter {
                    case .Chapter1:
                        ChapterOne(phase: state.stage, beehiveYear: Bindable(state).beehiveYear)
                    case .Chapter2:
                        ChapterTwo(phase: state.stage, pesticideYear: Bindable(state).pesticideYear, temperatureYear: Bindable(state).temperatureYear)
                    case .Chapter3:
                        ChapterThree(phase: state.stage, speed: Bindable(state).speed, pesticide: Bindable(state).pesticide, temperature: Bindable(state).temperature)
                    }
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                state.previous()
                            }
                        } label: {
                            Text("Go back")
                                .fontDesign(.rounded)
                                .bold()
                        }
                        .tint(.orange)
                        Spacer()
                        Button {
                            withAnimation {
                                if state.currentChapter == .Chapter3 && state.stage >= 3 {
                                    SimulationState.shared.beeCount = 20
                                    SimulationState.shared.flowerCount = 20
                                    SimulationState.shared.day = 1
                                    SimulationState.shared.pollen = 0
                                    SimulationState.shared.nectar = 0
                                    SimulationState.shared.pesticide = 0.1
                                    SimulationState.shared.temperature = 1.0
                                    withAnimation {
                                        showSimulation = true
                                    }
                                } else {
                                    state.next()
                                }
                            }
                        } label: {
                            Text("Next")
                                .fontDesign(.rounded)
                                .bold()
                        }
                        .tint(.orange)
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 30)
                .frame(width: geometry.size.width / 2)
                VStack {
                    switch state.currentChapter {
                    case .Chapter1:
                        BeehiveChart(year: Int(state.beehiveYear))
                            .padding(.horizontal, 30)
                    case .Chapter2:
                        VStack(spacing: 50) {
                            PesticideChart(year: Int(state.pesticideYear))
                            TempChart(year: Int(state.temperatureYear))
                        }
                        .padding()
                        .padding(.horizontal)
                    case .Chapter3:
                        SimulationTutorial()
                    }
                }
                .padding(.vertical, 50)
                .frame(width: geometry.size.width / 2)
            }
        }
        .background(.white)
        .padding()
        .onChange(of: state.pesticide) {
            SimulationState.shared.pesticide = state.pesticide
        }
        .onChange(of: state.speed) {
            SimulationState.shared.speed = 60 * state.speed
        }
        .onChange(of: state.temperature) {
            SimulationState.shared.temperature = state.temperature
        }
    }
}
