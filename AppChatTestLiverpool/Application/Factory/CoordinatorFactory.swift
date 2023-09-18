//
//  CoordinatorFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 13/09/23.
//

import UIKit
typealias InitialModuleFactory = SessionSceneFactory & ChatSceneFactory
protocol InitialCordinatorProtocol {
    func makeInitialCoordinator(parent: DelegateAppCoordinator, appContainer: AppContainer, delegate: DelegateAppCoordinator) -> Coordinator
}
class CoordinatorFactory: InitialCordinatorProtocol{
   
    
    let navigationController: UINavigationController
    let moduleFactory: InitialModuleFactory
    
    init(navigationController: UINavigationController, moduleFactory: InitialModuleFactory) {
        self.navigationController = navigationController
        self.moduleFactory = moduleFactory
    }
    
    func makeInitialCoordinator(parent: DelegateAppCoordinator, appContainer: AppContainer, delegate: DelegateAppCoordinator) -> Coordinator{
        let factory = ConversationFactory(appContainer: appContainer)
        let loginFactory = LoginFactory(appContainer: appContainer)
        return self.moduleFactory.isLogged() ? ConversationCoordinator(navigationController: self.navigationController, conversationFactory: factory, delegate: delegate) : LoginCoordinator(navigationController: navigationController, factory: loginFactory, appContainer: appContainer, delegate: delegate)
    }
}

