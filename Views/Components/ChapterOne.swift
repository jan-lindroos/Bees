import SwiftUI

struct ChapterOne: View {
    let phase: Int
    @Binding var beehiveYear: Double
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Bees are not just about making honey 🍯. They are key players in pollinating the plants we rely on for food. In fact, about one-third of the food we eat depends on bees – from fruits and vegetables to nuts and animal feed 🥑.")
                    .fontDesign(.monospaced)
                    .padding(.bottom)
                if phase >= 1 {
                    Text("But here's the thing – bees are under threat. Pesticides, habitat loss, climate change, diseases, and pests all play a part in the decline of bee populations 🪦. As we expand our cities and farms, we destroy the natural habitats bees need to thrive.")
                        .fontDesign(.monospaced)
                        .padding(.bottom)
                    Text("Use the slider below to see the change in the number of beehives in the United States 🇺🇸 (per UN data).")
                        .fontDesign(.monospaced)
                    VStack {
                        Text(verbatim: "Visualised year: \(Int(beehiveYear))")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Slider(value: $beehiveYear, in: 1961...2021)
                            .tint(.orange)
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 30)
                }
                if phase >= 2 {
                    Text("In this playground, we will explore how all of these factors affect bees by simulating a bee colony – and hopefully grasp the urgency of declining bee populations. Ready? Let's do this 🧑‍🚀!")
                        .fontDesign(.monospaced)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
