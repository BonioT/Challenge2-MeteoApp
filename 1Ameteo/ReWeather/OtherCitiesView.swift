import SwiftUI

struct OtherCitiesView: View {

    @State private var searchText = ""
    @State private var selectedCity: City? = nil
    @State private var showingMapDetails = false
    struct City: Identifiable {
        let id = UUID()
        let name: String
        let temperature: Int
    }

    let cities = [
        City(name: "Milan", temperature: 18),
        City(name: "Turin", temperature: 15),
        City(name: "Bologna", temperature: 20),
        City(name: "Naples", temperature: 24),
        City(name: "Florence", temperature: 22),
        City(name: "Rome", temperature: 28),
        City(name: "Venice", temperature: 21)
    ]

    //Weather symbol and color logic, same as TodayView
    func weatherSymbol(for temperature: Int) -> String {
        if temperature >= 26 {
            return "sun.max.fill"
        } else if temperature >= 22 {
            return "cloud.sun.fill"
        } else if temperature >= 18 {
            return "cloud.fill"
        } else {
            return "cloud.rain.fill"
        }
    }

    func colorForTemperature(_ temperature: Int) -> Color {
        if temperature >= 26 {
            return .yellow
        } else if temperature >= 22 {
            return .orange
        } else if temperature >= 18 {
            return .gray
        } else {
            return .blue
        }
    }

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(.sRGB, red: 0.1, green: 0.5, blue: 1, opacity: 1),
                                                Color(.sRGB, red: 0.3, green: 0.8, blue: 1.0, opacity: 1)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                ScrollView {
                    ForEach(cities.filter { searchText.isEmpty || $0.name.contains(searchText) }) { city in
                        HStack {
                            Text(city.name)
                            Spacer()
                            Text("\(city.temperature)°C")
                            Image(systemName: weatherSymbol(for: city.temperature))
                                .foregroundColor(colorForTemperature(city.temperature))
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .onTapGesture {
                            selectedCity = city
                        }
                        .sheet(item: $selectedCity) { city in
                            ZStack {
                                Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95)
                                    .ignoresSafeArea()
                                VStack(spacing: 24) {
                                    Text(city.name)
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .bold()
                                    HStack(spacing: 12) {
                                        Text("\(city.temperature)°C")
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Image(systemName: weatherSymbol(for: city.temperature))
                                            .font(.system(size: 64))
                                            .foregroundColor(colorForTemperature(city.temperature))
                                    }
                                    Text("Weather details and more coming soon !")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(12)
                                    
                                    Button("Close") {
                                        self.selectedCity = nil
                                    }
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                                }
                                .padding()
                            }
                        }
                    }

                    // MAP CARD
                    VStack {
                        ZStack {
                            Image("weathermap")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 120)
                                .clipped()
                                .cornerRadius(20)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.black.opacity(0.55))
                                        .cornerRadius(20)
                                )
                            Text("Map view coming soon!")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .onTapGesture {
                        showingMapDetails = true
                    }
                    .sheet(isPresented: $showingMapDetails) {
                        ZStack {
                            Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95)
                                .ignoresSafeArea()
                            VStack(spacing: 24) {
                                Text("Map Details")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .bold()
                                Image("weathermap")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(16)
                                    .frame(maxWidth: 320)
                                Text("Interactive and live maps will appear here soon!")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(12)
                                Button("Close") {
                                    showingMapDetails = false
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                            }
                            .padding()
                        }
                    }
                   

                }
                .navigationTitle(Text("Other Cities"))
            }
            .searchable(text: $searchText, prompt: "Search cities")
        }
    }
}

#Preview {
    OtherCitiesView()
}
