    //
    //  CharacterCell.swift
    //  RickAndMortyGraphQL
    //
    //  Created by mohit.dubey on 18/01/23.
    //

import SwiftUI

struct CharacterCell: View {
    @ObservedObject var vm: CharacterViewModel
    var columnWidth: CGFloat
    var body: some View {
        VStack {
            Image(uiImage: vm.image)
                .resizable()
                .frame(maxWidth: columnWidth)
                .frame(height: columnWidth)
                .scaledToFill()
                .clipped()
            
            
            Text(vm.character.char_name)
                .lineLimit(1)
                .truncationMode(.tail)
            Text("\(vm.character.char_species) - \(vm.character.char_episodesCount)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .onAppear {
            vm.getImage()
        }
        
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(vm: CharacterViewModel(character: GetAllCharactersQuery.Data.Character.Result(name: "My name", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", episode: [])) , columnWidth: UIScreen.main.bounds.width / 2)
    }
}
