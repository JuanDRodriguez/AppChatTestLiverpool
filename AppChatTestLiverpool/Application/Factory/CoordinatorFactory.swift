//
//  CoordinatorFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
typealias InitialModuleFactory = SessionSceneFactory & ChatSceneFactory
protocol InitialCordinatorProtocol {
    func makeInitialCoordinator(parent: DelegateAppCoordinator, appContainer: AppContainer) -> Coordinator
}
class CoordinatorFactory: InitialCordinatorProtocol{
   
    
    let navigationController: UINavigationController
    let moduleFactory: InitialModuleFactory
    let delegate: DelegateAppCoordinator
    
    init(navigationController: UINavigationController, moduleFactory: InitialModuleFactory, delegate: DelegateAppCoordinator) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
        self.delegate = delegate
    }
    
    func makeInitialCoordinator(parent: DelegateAppCoordinator, appContainer: AppContainer) -> Coordinator{
        let factory = ConversationFactory(appContainer: appContainer)
        let loginFactory = LoginFactory(appContainer: appContainer)
        return self.moduleFactory.isLogged() ? ConversationCoordinator(navigationController: self.navigationController, conversationFactory: factory,delegate: self.delegate) : LoginCoordinator(navigationController: navigationController, factory: loginFactory, appContainer: appContainer)
    }
}

