//
//  GraphQLNetwork.swift
//  RickAndMortyGraphQL
//
//  Created by mohit.dubey on 18/01/23.
//

import Foundation
import Apollo

final class GraphQLNetwork {
    private init() {}
    
    lazy var apolloClient = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
    static let shared = GraphQLNetwork()
}
