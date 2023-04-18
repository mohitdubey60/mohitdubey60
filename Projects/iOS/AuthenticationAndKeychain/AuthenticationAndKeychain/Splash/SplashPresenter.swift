//
//  SplashPresenter.swift
//  AuthenticationAndKeychain
//
//  Created by mohit.dubey on 21/03/23.
//

import Foundation

class SplashPresenter {
    weak var delegate: SplashViewControllerProtocol?
    weak var coordinatorDelegate: SplashCoordinatorProtocol?
    
    init(delegate: SplashViewControllerProtocol?, coordinatorDelegate: SplashCoordinatorProtocol? ) {
        self.delegate = delegate
        self.coordinatorDelegate = coordinatorDelegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            self?.requestRickAndMortyBaseUrlEntity()
        }
    }
}

// Controller work
extension SplashPresenter {
    func requestRickAndMortyBaseUrlEntity() {
        RickAndMortyHandshakeManager.shared.subscribeToList {[weak self] in
            self?.delegate?.rickAndMortyProcessingComplete()
            self?.navigateToNext()
        }
    }
}

// Coordinator work
extension SplashPresenter {
    func navigateToNext() {
        coordinatorDelegate?.navigateToNextAndDestroyCurrent()
    }
}
