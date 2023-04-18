//
//  RickAndMortyCharachterListViewPresenter.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 24/03/23.
//

import Foundation

class RickAndMortyCharachterListViewPresenter {
    let interactor: RickAndMortyCharachterListViewInteractor
    weak var delegate: RickAndMortyCharachterListViewControllerInteraction?
    
    init(interactor: RickAndMortyCharachterListViewInteractor, delegate: RickAndMortyCharachterListViewControllerInteraction? = nil) {
        self.interactor = interactor
        self.delegate = delegate
    }
}
