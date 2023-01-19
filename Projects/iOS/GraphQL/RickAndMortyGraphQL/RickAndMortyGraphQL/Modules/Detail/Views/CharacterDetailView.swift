    //
    //  CharacterDetailView.swift
    //  RickAndMortyGraphQL
    //
    //  Created by mohit.dubey on 18/01/23.
    //

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var vm: CharacterViewModel
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image(uiImage: vm.image)
                        .resizable()
                        .frame(height: 300)
                        .scaledToFill()
                        .clipped()
                        .blur(radius: 20)
                        .opacity(0.7)
                    
                    Image(uiImage: vm.image)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: 300)
                        .scaledToFill()
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                
                Text(vm.character.char_name)
                    .font(.title)
                
                Spacer()
            }
            .onAppear {
                vm.getImage()
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(vm: CharacterViewModel(character: GetAllCharactersQuery.Data.Character.Result(name: "My name", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", episode: [])))
    }
}
