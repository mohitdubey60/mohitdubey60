//
//  NetworkCallsWithCombineView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 26/12/22.
//

import SwiftUI

struct NetworkCallsWithCombineView: View {
    @ObservedObject var vm = NetworkCallsWithCombineViewModel()
    var body: some View {
        List(vm.allPosts) { post in
            Text(post.title ?? "")
                .font(.headline)
            Text(post.body ?? "")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .listStyle(.plain)
        .onAppear {
            vm.getAllUsers()
        }
    }
}

struct NetworkCallsWithCombineView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkCallsWithCombineView()
    }
}
