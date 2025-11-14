import SwiftUI

struct TodayView: View {

    @State private var selectedday = 0

    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    @State private var showingAirQualityDetails = false
    @State private var showingHumidityDetails = false
    @State private var showingUVDetails = false
    @State private var showingPressureDetails = false
    @State private var showingVisibilityDetails = false
    @State private var showingFeelsLikeDetails = false
    
    struct DayWeather {
        let city: String
        let temperature: Int
        let description: String
    }
    
    let weekWeather = [
        DayWeather(city: "Napoli", temperature: 20, description: "Sunny"),
        DayWeather(city: "Naples", temperature: 19, description: "Cloudy"),
        DayWeather(city: "Naples", temperature: 22, description: "Sunny"),
        DayWeather(city: "Naples", temperature: 24, description: "Partly Cloudy"),
        DayWeather(city: "Naples", temperature: 21, description: "Rainy"),
        DayWeather(city: "Naples", temperature: 23, description: "Sunny"),
        DayWeather(city: "Naples", temperature: 20, description: "Cloudy"),
    ]
    
    // Function for weather icons
    func weatherSymbol(for description: String) -> String {
        switch description {
        case "Sunny":
            return "sun.max.fill"
        case "Cloudy":
            return "cloud.fill"
        case "Partly Cloudy":
            return "cloud.sun.fill"
        case "Rainy":
            return "cloud.rain.fill"
        default:
            return "cloud.fill"
        }
    }
    // Colors for weather icons
    func colorForWeather(description: String) -> Color {
        switch description {
        case "Sunny":
            return .yellow
        case "Cloudy":
            return .gray
        case "Partly Cloudy":
            return .orange
        case "Rainy":
            return .blue
        default:
            return .gray
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
        let weather = weekWeather[selectedday]
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
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack(spacing: 8) {
                            Image(systemName: weatherSymbol(for: weather.description))
                                .font(.system(size: 40))
                                .foregroundColor(colorForWeather(description: weather.description))
                                .shadow(radius: 5)
                            Text(weather.city)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                        }
                        Text("\(weather.temperature)°C")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.leading, 50)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "gear")
                            }
                        }
                    }
                    .navigationTitle(Text(days[selectedday]))
                    .foregroundStyle(.white)

                    Picker("Days", selection: $selectedday) {
                        ForEach(0..<days.count, id: \.self) { index in
                            Text(days[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(16)
                    .padding(.bottom, 8)

                    // CARDS
                    VStack(spacing: 16) {
                        // Air Quality Card
                        ZStack {
                            Image("airqualitymap")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 110)
                                .clipped()
                                .cornerRadius(20)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.black.opacity(0.55))
                                        .cornerRadius(20)
                                )
                            HStack {
                                Text("Air Quality")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 110)
                        .background(.ultraThinMaterial.opacity(0.4))
                        .cornerRadius(20)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        .contentShape(Rectangle())
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

                        // HUMIDITY CARD
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "drop.fill")
                                Text("Humidity level")
                                    .font(.title)
                                    .bold()
                            }
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                .blue, .green, .yellow, .orange, .red, .purple
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(height: 5)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 10, height: 16)
                                    .shadow(radius: 2)
                                    .offset(x: 200)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
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
                        HStack(spacing: 16) {
                            // UV INDEX CARD
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: 8) {
                                    Image(systemName: "sun.min.fill")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text("UV INDEX")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .textCase(.uppercase)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                Text("3")
                                    .font(.system(size: 34, weight: .bold))
                                Text("Low")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                // SLIDER
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [.blue, .green, .yellow, .orange, .red, .purple]),
                                            startPoint: .leading,
                                            endPoint: .trailing))
                                        .frame(height: 7)
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 14, height: 14)
                                        .shadow(radius: 2)
                                        .offset(x: 40)
                                }
                                .padding(.vertical, 4)
                                Text("Low for the rest of the day.")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)
                            .contentShape(Rectangle())
                            .onTapGesture { showingUVDetails = true }
                            .sheet(isPresented: $showingUVDetails) {
                                ZStack {
                                    Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95).ignoresSafeArea()
                                    VStack {
                                        Text("UV Index Details")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        Text("Detailed UV Index info here.")
                                            .foregroundColor(.white)
                                        Button("Close") {
                                            showingUVDetails = false
                                        }
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(12)
                                        .foregroundColor(.white)
                                    }
                                    .padding()
                                }
                            }
                            
                            // PRESSURE CARD
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: 8) {
                                    Image(systemName: "gauge")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text("PRESSURE")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .textCase(.uppercase)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                Text("1016 hPa")
                                    .font(.system(size: 34, weight: .bold))
                                Text("Normal")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                // SLIDER
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.blue.opacity(0.3))
                                        .frame(height: 7)
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.blue)
                                        .frame(width: 80, height: 7)
                                }
                                .padding(.vertical, 4)
                                Text("Stable atmospheric pressure.")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)
                            .contentShape(Rectangle())
                            .onTapGesture { showingPressureDetails = true }
                            .sheet(isPresented: $showingPressureDetails) {
                                ZStack {
                                    Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95).ignoresSafeArea()
                                    VStack {
                                        Text("Pressure Details")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        Text("Detailed pressure info.")
                                            .foregroundColor(.white)
                                        Button("Close") {
                                            showingPressureDetails = false
                                        }
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(12)
                                        .foregroundColor(.white)
                                    }.padding()
                                }
                            }
                        }
                        .padding(.horizontal)

                        HStack(spacing: 16) {
                            // VISIBILITY CARD
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: 8) {
                                    Image(systemName: "eye")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text("VISIBILITY")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .textCase(.uppercase)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                Text("10 km")
                                    .font(.system(size: 34, weight: .bold))
                                Text("Clear")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                // SLIDER
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 7)
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.green)
                                        .frame(width: 120, height: 7)
                                }
                                .padding(.vertical, 4)
                                Text("Perfectly clear view.")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)
                            .contentShape(Rectangle())
                            .onTapGesture { showingVisibilityDetails = true }
                            .sheet(isPresented: $showingVisibilityDetails) {
                                ZStack {
                                    Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95).ignoresSafeArea()
                                    VStack {
                                        Text("Visibility Details")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        Text("Current and max visibility information.")
                                            .foregroundColor(.white)
                                        Button("Close") {
                                            showingVisibilityDetails = false
                                        }
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(12)
                                        .foregroundColor(.white)
                                    }
                                    .padding()
                                }
                            }
                            
                            // FEELS LIKE CARD
                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: 8) {
                                    Image(systemName: "thermometer")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text("FEELS LIKE")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .textCase(.uppercase)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                Text("18°C")
                                    .font(.system(size: 34, weight: .bold))
                                Text("Similar to actual")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                // SLIDER
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [.blue, .yellow, .red]),
                                            startPoint: .leading,
                                            endPoint: .trailing))
                                        .frame(height: 7)
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 14, height: 14)
                                        .shadow(radius: 2)
                                        .offset(x: 60)
                                }
                                .padding(.vertical, 4)
                                Text("It feels like the actual temperature.")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .frame(width: 180, height: 180)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                            .foregroundColor(.white)
                            .contentShape(Rectangle())
                            .onTapGesture { showingFeelsLikeDetails = true }
                            .sheet(isPresented: $showingFeelsLikeDetails) {
                                ZStack {
                                    Color(.sRGB, red: 0.13, green: 0.15, blue: 0.2, opacity: 0.95).ignoresSafeArea()
                                    VStack {
                                        Text("Feels Like Details")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        Text("More feels like temperature info.")
                                            .foregroundColor(.white)
                                        Button("Close") {
                                            showingFeelsLikeDetails = false
                                        }
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(12)
                                        .foregroundColor(.white)
                                    }.padding()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    TodayView()
}
