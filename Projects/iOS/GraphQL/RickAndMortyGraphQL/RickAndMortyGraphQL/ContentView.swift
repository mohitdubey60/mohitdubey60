//  ContentView.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                NavigationView {
                    CharacterListView(vm: CharacterListViewModel())
                        .navigationTitle("Characters")
                }
            }
            .tabItem {
                Label("Charachters", systemImage: "brain.head.profile")
            }
            
            VStack {
                NavigationView {
                    EpisodesListView(vm: EpisodesListViewModel())
                        .navigationTitle("Episodes")
                }
            }
            .tabItem {
                Label("Episodes", systemImage: "mail.stack")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
