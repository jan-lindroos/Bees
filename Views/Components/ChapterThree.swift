import SwiftUI

struct ChapterThree: View {
    let phase: Int
    @Binding var speed: Double
    @Binding var pesticide: Double
    @Binding var temperature: Double
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Every morning, bees leave their hive and pollinate one flower each (turning it red) 🌹. Nectar and pollination allow the colony to support more bees and plants. There is a 30% chance bees and plants don't make it to the next day.")
                        .fontDesign(.monospaced)
                    VStack {
                        Text("Speed modifier: \(String(format: "%.1f", speed))x")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: $speed, in: 0.5...3.0)
                            .tint(.orange)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 30)
                    if phase >= 1 {
                        Text("Oh no! The nearby farmer started using pesticide. Black flowers are poisoned with pesticide and kill any bee that touches them. 🧪")
                            .fontDesign(.monospaced)
                        VStack {
                            Text("Pesticide chance: \(Int(pesticide * 100))%")
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                            Slider(value: $pesticide, in: 0.0...1.0)
                                .tint(.orange)
                                .padding(.horizontal)
                        }
                        .padding(.vertical, 30)
                    }
                    if phase >= 2 {
                        Text("Temperature also affects bees 🌡️. The hotter it is, the greater the likelihood of bees getting sick, decreasing the survival rate. High temperatures also make them dizzy.")
                            .fontDesign(.monospaced)
                        VStack {
                            Text("Climate: +\(Int(temperature)) °C")
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                            Slider(value: $temperature, in: 0.0...5.0)
                                .tint(.orange)
                                .padding(.horizontal)
                        }
                        .padding(.vertical, 30)
                    }
                    if phase >= 3 {
                        Text("Thank you so much for engaging! Let's simulate! 🍯")
                            .fontDesign(.monospaced)
                            .padding(.bottom)
                    }
                }
            }
            .scrollIndicators(.hidden)
    }
}
