//
//  ContentView.swift
//  RickMorty
//
//  Created by Rafael Loggiodice on 13/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel:RickMortyViewModel=RickMortyViewModel()
    @State private var dark = false
    @State var darkText = Text("Turn for dark")
    @State var lightText = Text("Turn for light")
    @State var Rafa = Text("Rafael")
    @State var LastN = Text("Loggiodice")
    @State private var searchText = ""
    
    
    
    
    var body: some View {
        VStack {
            HStack{
                Toggle(isOn: $dark) {
                    if dark == false{
                        darkText
                            .fontWeight(.medium)
                            .toggleStyle(.automatic)
                            .preferredColorScheme(.light)
                        Rafa
                        lightText.hidden()
                    } else {
                        lightText
                            .fontWeight(.medium)
                            .toggleStyle(.automatic)
                            .preferredColorScheme(.dark)
                        LastN
                    }
                }
                .padding()
                
            }
            NavigationView{
                
                VStack{
                    switch viewModel .charactersState{
                    case .initial:
                        ProgressView()
                    case .loading:
                        ProgressView()
                    case .error(let error):
                        Text(error)
                    case .loaded(let data):
                        
                        ScrollView {
                            
                            ForEach(data.results){ results in
                                HStack {
                                    
                                    AsyncImage(url: URL(string: results.image)){image in
                                        image.resizable()
                                            .cornerRadius(25)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                    VStack(alignment:.leading) {
                                        Text(results.name)
                                            .font(.headline)
                                            .fontWeight(.medium)
                                        Text(results.gender)
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                        Text(results.status)
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                        Text(results.location.name)
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    Text(results.species)
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .navigationTitle("Characters")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
