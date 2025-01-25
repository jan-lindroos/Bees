import SwiftUI

struct SimulationMenu: View {
    var simState = SimulationState.shared
    @State var speedModifier = 1.0
    @State var isHidden = true
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Spacer()
                Button {
                    withAnimation {
                        isHidden.toggle()
                    }
                } label: {
                    Text("Configuration ⚙️")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding()
                        .frame(height: 40)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Button {
                    simState.beeCount += 1
                } label: {
                    Text("Add 🐝")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding()
                        .frame(height: 40)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Button {
                    simState.flowerCount += 1
                } label: {
                    Text("Add 🌸")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding()
                        .frame(height: 40)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer()
            }
            .padding(.bottom)
                HStack {
                    VStack {
                        Text("Speed modifier: \(String(format: "%.1f", speedModifier))x")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: $speedModifier, in: 0.5...3.0)
                            .tint(.orange)
                            .padding(.horizontal)
                            .onChange(of: speedModifier) {
                                simState.speed = 60 * speedModifier
                            }
                    }
                    .frame(width: 210, height: 50)
                    VStack {
                        Text("Pesticide chance: \(Int(simState.pesticide * 100))%")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: Bindable(simState).pesticide, in: 0.0...1.0)
                            .tint(.orange)
                            .padding(.horizontal)
                    }
                    .frame(width: 210, height: 50)
                    VStack {
                        Text("Climate: +\(Int(simState.temperature)) °C")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: Bindable(simState).temperature, in: 0.0...5.0)
                            .tint(.orange)
                            .padding(.horizontal)
                    }
                    .frame(width: 210, height: 50)
                    VStack {
                        Text("Survival rate: \(Int(simState.survival * 100))%")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: Bindable(simState).survival, in: 0.0...1.0)
                            .tint(.orange)
                            .padding(.horizontal)
                    }
                    .frame(width: 210, height: 50)
                    VStack {
                        Text("Reproduction rate: \(Int(simState.reproduction * 100))%")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: Bindable(simState).reproduction, in: 0.0...1.0)
                            .tint(.orange)
                            .padding(.horizontal)
                    }
                    .frame(width: 210, height: 50)
                }
                .padding(30)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 30)
            }
            .offset(y: isHidden ? 140 : 0)
    }
}
