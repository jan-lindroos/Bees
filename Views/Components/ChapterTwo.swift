import SwiftUI

struct ChapterTwo: View {
    let phase: Int
    @Binding var pesticideYear: Double
    @Binding var temperatureYear: Double
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Pesticides are deadly to bees. Their effects range from disorienting bees (meaning they can't find as much nectar) to outright killing them 🚱. The use of pesticides has been increasing globally.")
                    .fontDesign(.monospaced)
                    .padding(.bottom)
                Text("Check out the use of pesticides in the 5 largest economies over the past 3 decades 🚜 (per UN data).")
                    .fontDesign(.monospaced)
                VStack {
                    Text(verbatim: "Visualised year: \(Int(pesticideYear))")
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                    Slider(value: $pesticideYear, in: 1990...2021)
                        .tint(.orange)
                        .padding(.horizontal)
                }
                .padding(.vertical, 30)
                if phase >= 1 {
                    Text("Climate change threatens bees in two ways. First, changes in weather patterns damage the ecosystems they live in. Second, increased temperatures make it easier for harmful parasites and diseases to spread. ☀️")
                        .fontDesign(.monospaced)
                        .padding(.bottom)
                    Text("Observe the effects of global warming on global temperatures ♨️ (per NASA data).")
                        .fontDesign(.monospaced)
                    VStack {
                        Text(verbatim: "Visualised year: \(Int(temperatureYear))")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: $temperatureYear, in: 1880...2023)
                            .tint(.orange)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 30)
                }
                if phase >= 2 {
                    Text("Amazing work! Let's apply what you've learnt! In the next chapter, you'll learn how the simulator works. 🌷")
                        .fontDesign(.monospaced)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
