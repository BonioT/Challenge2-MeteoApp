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
    
    let listaDiCitta = [
        Citta(nome: "Milano", gradi: 18),
        Citta(nome: "Torino", gradi: 15),
        Citta(nome: "Bologna", gradi: 20)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { }) {
                    Image(systemName: "line.3.horizontal")
                }.padding()
                
                if tab == 1 {
                    Text("Napoli")
                        .font(.largeTitle)
                }
            }
            
            TabView(selection: $tab) {
                TodayView()
                    .tabItem {
                        Image(systemName: "sun.max")
                        Text("Today")
                    }
                    .tag(1)
                WeekView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("This week")
                    }
                    .tag(2)
                OtherCitiesView(listaDiCitta: listaDiCitta)
                    .tabItem {
                        Image(systemName: "globe")
                        Text("Other")
                    }
                    .tag(3)
            }
        }
        .padding(.top)
    }
}

#Preview {
    ContentView()
}
