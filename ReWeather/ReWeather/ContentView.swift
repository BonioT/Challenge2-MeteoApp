//
//  ContentView.swift
//  1Ameteo
//
//  Created by Antonio Bonetti on 07/11/25.
//

import SwiftUI


struct Citta {
    let nome: String
    let gradi: Int
}

struct ContentView: View {
    @State private var tab: Int = 1
    
   
    
    
    var body: some View {
        
            TabView(selection: $tab) {
                TodayView()
                    .tabItem {
                        Image(systemName: "sun.max")
                        Text("Daily")
                    }
                    .tag(1)
                //            WeekView()
                //                .tabItem {
                //                    Image(systemName: "calendar")
                //                    Text("This week")
                //                }
                //                .tag(2)
                OtherCitiesView()
                    .tabItem {
                        Image(systemName: "globe")
                        Text("Other")
                    }
                    .tag(3)
            }
        }
    }



#Preview {
    ContentView()
}
