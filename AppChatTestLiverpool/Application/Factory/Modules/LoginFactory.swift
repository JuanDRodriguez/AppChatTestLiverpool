//
//  LoginFactory.swift
//  AppChatTestLiverpool
//
//  Created by JuanD Rodriguez on 15/09/23.
//

import UIKit
protocol LoginFactoryProtocol {
    func makeModule(coordinator: LoginCoordinatorInput) -> UIViewController
    func makeCoordinator(navigationController: UINavigationController, appContainer: AppContainer, delegate: DelegateAppCoordinator) -> Coordinator
    func makeCoordinatorRegister(navigationController: UINavigationController, appContainer: AppContainer, delegate: DelegateAppCoordinator) -> Coordinator
}
class LoginFactory: LoginFactoryProtocol{
    
    let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    func makeModule(coordinator: LoginCoordinatorInput) -> UIViewController{
        let repository = SessionRepository(databaseService: appContainer.dataService, storageService: appContainer.storageService, authService: appContainer.authService)
        let useCase = LoginUseCase(repository: repository)
        let viewController = LoginViewController.instantiate(storyboardName: "Session")
        let viewModel = LoginViewModel(controller: viewController, useCase: useCase)
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        return viewController
    }
    func makeCoordinator(navigationController: UINavigationController, appContainer: AppContainer, delegate: DelegateAppCoordinator) -> Coordinator {
        let factory = ConversationFactory(appContainer: appContainer)
        return ConversationCoordinator(navigationController: navigationController, conversationFactory: factory, delegate: delegate)
    }
    func makeCoordinatorRegister(navigationController: UINavigationController, appContainer: AppContainer, delegate: DelegateAppCoordinator) -> Coordinator{
        let factory = RegisterFactory(appContainer: appContainer, delegate: delegate)
        return RegisterCoordinator(navigationController: navigationController, factory: factory, appContainer: appContainer)
    }
    
}
