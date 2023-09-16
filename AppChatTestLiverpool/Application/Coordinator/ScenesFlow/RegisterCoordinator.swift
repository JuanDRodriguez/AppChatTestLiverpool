//
//  RegisterCoordinator.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
class RegisterCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    let factory: RegisterFactoryProtocol
    var appContainer: AppContainer
    
    init(navigationController: UINavigationController, factory: RegisterFactoryProtocol, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.factory = factory
        self.appContainer = appContainer
    }
    
    func start() {
        let vc = self.factory.makeModule(coordinator: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
}
extension RegisterCoordinator: RegisterCoordinatorInput{
    func showLogin() {
        let coordinator = self.factory.makeCoordinator(navigationController: self.navigationController, appContainer: appContainer)
        coordinator.start()
    }
    
    
}
