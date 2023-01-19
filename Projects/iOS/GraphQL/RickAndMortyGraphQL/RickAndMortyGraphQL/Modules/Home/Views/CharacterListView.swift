//
//  CharacterListView.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var vm: CharacterListViewModel
    
    func getColumns() -> [GridItem] {
        let width = (UIScreen.main.bounds.width / CGFloat(2)) - 24
        
        let gridColumns = Array(repeating:  GridItem(.fixed(width), spacing: 4), count: 2)
        return gridColumns
    }
    
    var columnWidth: CGFloat {
        (UIScreen.main.bounds.width / CGFloat(2))
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: getColumns(), spacing: 10) {
                    ForEach(vm.allCharacters, id: \.char_id) { item in
                        NavigationLink(destination: CharacterDetailView(vm: CharacterViewModel(character: item))) {
                            CharacterCell(vm: CharacterViewModel(character: item),
                                          columnWidth: columnWidth)
                            .frame(maxWidth: columnWidth)
                        }
                    }
                }
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(vm: CharacterListViewModel())
    }
}
