import SwiftUI

struct TodayView: View {

    @State private var selectedday = 0

    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    @State private var showingAirQualityDetails = false
    @State private var showingHumidityDetails = false
    
    struct DayWeather {
        let city: String
        let temperature: Int
        let description: String
    }
    

    let weekWeather = [
        DayWeather(city: "Naples", temperature: 20, description: "Sunny"),
        DayWeather(city: "Naples", temperature: 19, description: "Cloudy"),
        DayWeather(city: "Naples", temperature: 22, description: "Sunny"),
        DayWeather(city: "Naples", temperature: 24, description: "Partly Cloudy"),
        DayWeather(city: "Naples", temperature: 21, description: "Rainy"),
        DayWeather(city: "Naples", temperature: 23, description: "Sunny"),
        DayWeather(city: "Naples", temperature: 20, description: "Cloudy"),
    ]
    
    

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
                                                Color(.sRGB, red: 0.3, green: 0.8, blue: 1, opacity: 1)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                ScrollView {
                    let weather = weekWeather[selectedday]
                    VStack {
                        Text(weather.city)
                            .font(.largeTitle)
                            .bold()
                        Text("\(weather.temperature)°C")
                            .font(.title)
                        Text(weather.description)
                            .font(.headline)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                //button action
                            }) {
                                Image(systemName: "gear")
                            }
                        }
                    }.navigationTitle(Text(days[selectedday]))
                        .foregroundStyle(.white)

                    Picker("Days", selection: $selectedday) {
                        ForEach(0..<days.count, id: \.self) { index in
                            Text(days[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(16)

                    VStack(spacing: 16) {
                        // Air Quality Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Air Quality")
                                .font(.headline)
                            Text("Good")
                                .font(.title)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .onTapGesture {
                            showingAirQualityDetails = true
                        }
                        .sheet(isPresented: $showingAirQualityDetails) {
                            ZStack {
                                Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95)
                                    .ignoresSafeArea()
                                VStack {
                                    Text("Air Quality Details")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                    Text("More details")
                                        .foregroundColor(.white)
                                    Button("Close") {
                                        showingAirQualityDetails = false
                                    }
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                                }
                                .padding()
                            }
                        }

                        // Humidity Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Humidity level")
                                .font(.headline)
                            Text("Good")
                                .font(.title)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .onTapGesture {
                            showingHumidityDetails = true
                        }
                        .sheet(isPresented: $showingHumidityDetails) {
                            ZStack {
                                Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95)
                                    .ignoresSafeArea()
                                VStack {
                                    Text("Humidity level Details")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                    Text("More details")
                                        .foregroundColor(.white)
                                    Button("Close") {
                                        showingHumidityDetails = false
                                    }
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                                }
                                .padding()
                            }
                        }

                        // Quadrate cards (no sheets qui, ma puoi aggiungere come sopra)
                        HStack(spacing: 16) {
                            VStack {
                                Text("UV Index")
                                    .font(.headline)
                                Text("3")
                                    .font(.title)
                            }
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)

                            VStack {
                                Text("Pressure")
                                    .font(.headline)
                                Text("1016 hPa")
                                    .font(.title)
                            }
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)
                        }
                        .padding(.horizontal)

                        HStack(spacing: 16) {
                            VStack {
                                Text("Visibility")
                                    .font(.headline)
                                Text("10 km")
                                    .font(.title)
                            }
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)

                            VStack {
                                Text("Feels Like")
                                    .font(.headline)
                                Text("18°C")
                                    .font(.title)
                            }
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TodayView()
}
