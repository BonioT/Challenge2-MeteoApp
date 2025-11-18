ReWeather – SwiftUI Weather App

ReWeather is a small sample iOS app built with SwiftUI.
It focuses on showing daily weather in a clean way and experimenting with a modern SwiftUI UI.

The app shows:
- Daily weather with informative cards (air quality, humidity, UV, pressure, visibility, “feels like”)
- A list of other cities with temperature and weather icons, with more details in sheets
- A placeholder screen called “WeekView” for future weekly weather


Platform and technologies

- Platform: iOS  
- Language: Swift  
- UI: SwiftUI, NavigationStack, TabView  
- Recommended: Xcode 15 or later, iOS 17 or later (update this if your setup is different)


Project structure

The main files in the project are:

- `ReWeather.swift`  
  App entry point.

- `ContentView.swift`  
  Hosts the main `TabView`, with the “Daily” and “Other” sections.

- `TodayView.swift`  
  The main daily weather screen.  
  It shows several cards and can open detail sheets for more information.

- `OtherCitiesView.swift`  
  Shows a list of cities with temperature and weather icons.  
  The user can search in the list and open detail sheets for each city.  
  It also includes a “Map view coming soon!” card as a placeholder.

- `WeekView.swift`  
  A simple placeholder view for future weekly weather.


Features

- Day selection with a segmented `Picker` in `TodayView`
- Informational cards that open detail sheets
- Filterable city list with search and city detail sheets (`OtherCitiesView`)
- Modern look with gradients, blur materials (`.ultraThinMaterial`) and SF Symbols


How to run

1. Open the project in Xcode.
2. Select an iOS Simulator or a real device.
3. Press Run (⌘R).


Dependencies

- No external dependencies.  
- The app uses only SwiftUI and local assets (for example the images `airqualitymap` and `weathermap`).


Author

Made by **Antonio Bonetti**.
