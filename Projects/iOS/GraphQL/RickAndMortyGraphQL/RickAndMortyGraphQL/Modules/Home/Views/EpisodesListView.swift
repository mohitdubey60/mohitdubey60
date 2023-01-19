    //
    //  EpisodesListView.swift
    //  RickAndMortyGraphQL
    //
    //  Created by mohit.dubey on 18/01/23.
    //

import SwiftUI

struct EpisodesListView: View {
    @StateObject var vm: EpisodesListViewModel
    var body: some View {
        List(vm.episodes, id: \.episode_id) { item in
            NavigationLink(destination: EpisodeDetailView()) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.episode_name)
                        Text(item.episode_airDate)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(item.episode_seq)
                        Text("characters - \(item.episode_characters.count)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView(vm: EpisodesListViewModel())
    }
}
