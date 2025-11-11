import SwiftUI

struct OtherCitiesView: View {
    let listaDiCitta: [Citta]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(listaDiCitta, id: \.nome) { città in
                        Button(action: {
                        }) {
                            HStack {
                                Text(città.nome)
                                Spacer()
                                Text("\(città.gradi)°C")
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationTitle(Text("Other Cities"))
                .padding(.top)
            }
        }
    }
}
