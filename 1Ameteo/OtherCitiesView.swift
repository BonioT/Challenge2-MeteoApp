import SwiftUI

struct OtherCitiesView: View {

    @State private var searchText = ""

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

    @State private var selectedCity: City? = nil

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
                            Image(systemName: "cloud.sun.fill")
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
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            self.selectedCity = nil
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 32))
                                                .foregroundColor(.white)
                                        }
                                    }.padding()
                                    Text(city.name)
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .bold()
                                    Image(systemName: "cloud.sun.fill")
                                        .font(.system(size: 64))
                                        .foregroundColor(.white)
                                    Text("\(city.temperature)°C")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text("Weather details and more coming soon !")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(12)
                                }
                                .padding()
                            }
                        }
                    }

                    VStack {
                        Text("Map view coming soon!")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .foregroundColor(.white)

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
