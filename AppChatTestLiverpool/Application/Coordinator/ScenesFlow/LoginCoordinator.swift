//
//  LoginCoordinator.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    let factory: LoginFactoryProtocol
    var appContainer: AppContainer
    init(navigationController: UINavigationController, factory: LoginFactoryProtocol, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.factory = factory
        self.appContainer = appContainer
    }
    func start() {
        let vc = factory.makeModule(coordinator: self)
        self.navigationController.modalPresentationStyle = .overFullScreen
        self.navigationController.setViewControllers([vc], animated: true)
    }

}
extension LoginCoordinator: LoginCoordinatorInput{
    func showRegister() {
        let coordinator = factory.makeCoordinatorRegister( navigationController: self.navigationController, appContainer: self.appContainer)
        coordinator.start()
    }
    
    func showFlowChat(user: String) {
        self.appContainer.id = user
        let coordinator = factory.makeCoordinator(navigationController: self.navigationController, appContainer: self.appContainer)
        coordinator.start()
    }
    
    
}
